import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Translates {
  Translates(this.locale);

  final Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  static String trackingLanguage = 'en';

  static Translates of(BuildContext context) {
    return Localizations.of<Translates>(context, Translates);
  }

  static Map<String, String> _sentences;

  static Future<Translates> load(Locale locale) async {
    final Translates translations = new Translates(locale);
    trackingLanguage = translations.currentLanguage;
    final String jsonContent =
        await rootBundle.loadString('assets/langs/$trackingLanguage.json');
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;

  static String trans(String key, {Map args}) {
    String result = _sentences[key] ?? key;
    if (args != null) {
      args.forEach((key, value) {
        result = result.replaceAll('{$key}', value);
      });
    }
    return result;
  }
}
