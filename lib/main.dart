import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/pages/home/home_page.dart';
import 'package:flutter_boilerplate/providers/base_provider.dart';
import 'package:flutter_boilerplate/routes.dart';
import 'package:flutter_boilerplate/services/locator.dart';
import 'package:flutter_boilerplate/services/shared_pref/shared_pref.dart';
import 'package:flutter_boilerplate/utils/error_capture.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'generated/i18n.dart';

final SentryClient _sentry = SentryClient(dsn: Strings.dnsSentry);

List<Future> systemChromeTasks = [
  SystemChrome.setEnabledSystemUIOverlays([]),
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ])
];

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await initializeDateFormatting();
  await Future.wait(systemChromeTasks);
  setupLocator();
  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BaseProvider()),
        ],
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) async {
    await reportError(_sentry, error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: HomePage(),
    );
  }
}
