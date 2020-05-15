import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(child: Text('home page')),
          IconButton(icon: Icon(Icons.change_history), onPressed: () {})
        ],
      ),
    );
  }
}
