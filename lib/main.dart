import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'pages/home/home_page.dart';
import 'providers/base_provider.dart';
import 'routes.dart';
import 'services/locator.dart';
import 'services/shared_pref/shared_pref.dart';
import 'utils/error_capture.dart';
import 'utils/translation.dart';



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
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: HomePage(),
      supportedLocales: [
        const Locale('en'),
        const Locale('vi'),
      ],
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale != null) {
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
