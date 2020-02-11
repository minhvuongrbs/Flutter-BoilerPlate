import 'package:flutter/material.dart';
import 'package:gamerdual_flutter/constants/images.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(Images.logo),
            SizedBox(
              child: new CircularProgressIndicator(),
              height: 80.0,
              width: 80.0,
            )
          ],
        ),
      ),
    );
  }
}
