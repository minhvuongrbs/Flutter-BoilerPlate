import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Translations {
  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  static String trackingLanguage = "en";

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static String text(String key) {
    if (_localizedValues == null) return "";
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    trackingLanguage = translations.currentLanguage;
    String jsonContent =
        await rootBundle.loadString("assets/langs/$trackingLanguage.json");
    _localizedValues = json.decode(jsonContent);
    print(translations.currentLanguage);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
