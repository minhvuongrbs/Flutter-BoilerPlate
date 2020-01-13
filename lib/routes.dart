import 'package:flutter/material.dart';
import 'package:gamerdual_flutter/pages/home/home_page.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{

    home: (BuildContext context) => HomePage(),
  };
}
