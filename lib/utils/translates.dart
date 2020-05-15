import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/constants/app_constant.dart';
import 'package:flutter_boilerplate/services/shared_pref/shared_pref.dart';

class Translates {
  Translates(this.locale);

  final Locale locale;

  static Translates of(BuildContext context) {
    return Localizations.of<Translates>(context, Translates);
  }

  static Map<String, String> _sentences;

  Future<bool> load() async {
    String currentLang = SharedPref.sharedPref.getString(CONFIG_LANG);
    if (currentLang == null) {
      currentLang = DEFAULT_LANG;
      SharedPref.sharedPref.setString(CONFIG_LANG, currentLang);
    }
    final String data =
        await rootBundle.loadString('assets/langs/$currentLang.json');
    final Map<String, dynamic> _result = json.decode(data);

    _sentences = new Map();
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

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
