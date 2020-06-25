import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/routes.dart';
import 'package:flutter_boilerplate/utils/translation.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                Translations.text('home_page'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                String newLanguageCode;
                if (Translations.trackingLanguage == 'vi') {
                  newLanguageCode = 'en';
                } else
                  newLanguageCode = 'vi';
                print('new language: ' + newLanguageCode);
                Translations.load(Locale(newLanguageCode));
                Navigator.pushNamed(context, Routes.post_detail);
              },
              child: Text(Translations.text('change_language')),
              color: Colors.pinkAccent,
            ),
            Text(
              'Current language: ' + Translations.trackingLanguage,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
