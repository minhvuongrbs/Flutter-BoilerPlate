import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui show window;

import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry/sentry.dart';

import 'package:system_info/system_info.dart';

const int MEGABYTE = 1024 * 1024;

typedef Future<Null> ErrorReporter(Object error, StackTrace stackTrace);
typedef Widget ErrorReportingWidget(ErrorReporter reporter);

bool get _isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> reportError(
    SentryClient sentry, Object error, StackTrace stackTrace) async {
  print('Caught error: $error');
  // TODO(VuongTran): when release application will enable it to only detect in production mode
  /// if (_isInDebugMode) {
  ///   print(stackTrace);
  ///   In dev mode. Not sending report to Sentry.io.
  ///   return;
  /// }

  print('Reporting to Sentry.io...');

  final PackageInfo info = await PackageInfo.fromPlatform();

  final Map<String, dynamic> extra = {};
  final Map<String, String> deviceInfo = {};

  try {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidDeviceInfo =
          await deviceInfoPlugin.androidInfo;
      deviceInfo['device_name'] = androidDeviceInfo.model;
      deviceInfo['physical_device'] =
          androidDeviceInfo.isPhysicalDevice.toString();
      deviceInfo['Android_version'] = androidDeviceInfo.version.release;
      deviceInfo['API_level'] = androidDeviceInfo.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo['device_name'] = iosDeviceInfo.utsname.machine;
      deviceInfo['physical_device'] = iosDeviceInfo.isPhysicalDevice.toString();
      deviceInfo['version'] = iosDeviceInfo.utsname.release;
      deviceInfo['node_name'] = iosDeviceInfo.utsname.nodename;
      deviceInfo['model'] = iosDeviceInfo.model;
    }
    extra['device_info'] = deviceInfo;
  } catch (error) {
    extra['device_info'] = "Can't get device info";
  }

  final String mode = _isInDebugMode ? 'debug' : 'release';

  final Map<String, String> tags = {};
  tags['platform'] =
      defaultTargetPlatform.toString().substring('TargetPlatform.'.length);
  tags['package_name'] = info.packageName;
  tags['build_number'] = info.buildNumber;
  tags['version'] = info.version;
  tags['mode'] = mode;
  tags['locale'] = Platform.localeName.toString();

  final ConnectivityResult connectivity =
      await Connectivity().checkConnectivity();
  tags['connectivity'] =
      connectivity.toString().substring('ConnectivityResult.'.length);

  final Map<String, dynamic> uiValues = {};
  uiValues['locale'] = Platform.localeName.toString();
  uiValues['pixel_ratio'] = ui.window.devicePixelRatio;
  uiValues['default_route'] = ui.window.defaultRouteName;
  uiValues['physical_size'] = [
    ui.window.physicalSize.width,
    ui.window.physicalSize.height
  ];
  uiValues['text_scale_factor'] = ui.window.textScaleFactor;
  uiValues['view_insets'] = [
    ui.window.viewInsets.left,
    ui.window.viewInsets.top,
    ui.window.viewInsets.right,
    ui.window.viewInsets.bottom
  ];
  uiValues['padding'] = [
    ui.window.padding.left,
    ui.window.padding.top,
    ui.window.padding.right,
    ui.window.padding.bottom
  ];
  if (WidgetsBinding.instance != null) {
    // Removed the widget tree as it posts too much information.
    /*
		if (WidgetsBinding.instance.renderViewElement != null) {
			uiValues['render_view'] = WidgetsBinding.instance.renderViewElement.toStringDeep();
		} else {
			uiValues['render_view'] = '<no tree currently mounted>';
		}
		*/
  }
  extra['ui'] = uiValues;

  final Map<String, dynamic> memory = {};
  try {
    memory['phys_total'] = '${SysInfo.getTotalPhysicalMemory() ~/ MEGABYTE}MB';
    memory['phys_free'] = '${SysInfo.getFreePhysicalMemory() ~/ MEGABYTE}MB';
    memory['virt_total'] = '${SysInfo.getTotalVirtualMemory() ~/ MEGABYTE}MB';
    memory['virt_free'] = '${SysInfo.getFreeVirtualMemory() ~/ MEGABYTE}MB';
    extra['memory'] = memory;
  } catch (error) {
    extra['memory'] = "Can't get memory info";
  }

  extra['dart_version'] = Platform.version;

  final Event event = Event(
    loggerName: '',
    exception: error,
    stackTrace: stackTrace,
    release: '${info.version}_${info.buildNumber}',
    environment: 'qa',
    tags: tags,
    extra: extra,
  );

  try {
    final SentryResponse response = await sentry.capture(event: event);
    if (response.isSuccessful) {
      print('Success! Event ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry.io: ${response.error}');
    }
  } catch (e, stackTrace) {
    print('Exception whilst reporting to Sentry.io\n' + stackTrace.toString());
  }
}
