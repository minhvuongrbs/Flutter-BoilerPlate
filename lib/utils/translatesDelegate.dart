import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/translates.dart';

class TranslatesDelegate extends LocalizationsDelegate<Translates> {
  const TranslatesDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<Translates> load(Locale locale) => Translates.load(locale);

  @override
  bool shouldReload(TranslatesDelegate old) => false;
}
