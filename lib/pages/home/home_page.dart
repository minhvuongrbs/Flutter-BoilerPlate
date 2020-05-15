import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/services/shared_pref/shared_pref.dart';
import 'package:flutter_boilerplate/utils/translates.dart';
import 'package:flutter_boilerplate/utils/translatesDelegate.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                Translates.trans('home_page'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                String newLanguageCode;
                if (SharedPref.sharedPref.getString(CONFIG_LANG) == 'vi') {
                  newLanguageCode = 'en';
                } else
                  newLanguageCode = 'vi';

                SharedPref.sharedPref.setString(CONFIG_LANG, newLanguageCode);
                TranslatesDelegate().load(Locale(newLanguageCode));
              },
              child: Text('Change language'),
              color: Colors.pinkAccent,
            )
          ],
        ),
      ),
    );
  }
}
