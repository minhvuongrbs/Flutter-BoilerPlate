import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/components/common/app_loader.dart';

import '../constants/strings.dart';

class AppUtility {
  showProgressDialog(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AppLoader();
        });
  }

  showMessageDialog(BuildContext context, String message,
      {String title = Strings.appName,
        String positiveText = 'Okay',
        bool cancelable = true,
        VoidCallback onPressed}) {
    onPressed ??= () {
        Navigator.pop(context);
      };
    showDialog<dynamic>(
        context: context,
        barrierDismissible: cancelable,
        builder: (context) =>
            AlertDialog(
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    positiveText,
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: onPressed,
                )
              ],
            ));
  }

  showConfirmDialog(BuildContext context, String message,
      VoidCallback onPressed,
      {String title = Strings.appName,
        String negativeText = 'No',
        String positiveText = 'Yes',
        bool cancelable = true}) {
    showDialog<dynamic>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  negativeText,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  positiveText,
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .accentColor,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: onPressed,
              ),
            ],
          ),
    );
  }
}