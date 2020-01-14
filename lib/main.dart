import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gamerdual_flutter/pages/home/home_page.dart';
import 'package:gamerdual_flutter/providers/base_provider.dart';
import 'package:gamerdual_flutter/routes.dart';
import 'package:gamerdual_flutter/services/locator.dart';
import 'package:gamerdual_flutter/services/shared_pref/shared_pref.dart';
import 'package:gamerdual_flutter/utils/error_capture.dart';
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
  await SharedPref.init();
  await initializeDateFormatting();
  await Future.wait(systemChromeTasks);
  setupLocator();
  runZoned<Future<void>>(() async {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BaseProvider()),
        ],
        child: MyApp(),
      ),
    );
  }, onError: (error, stackTrace) async {
    await reportError(_sentry, error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: HomePage(),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}
