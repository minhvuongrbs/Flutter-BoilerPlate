import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                'home page',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Change language'),
              color: Colors.pinkAccent,
            )
          ],
        ),
      ),
    );
  }
}
