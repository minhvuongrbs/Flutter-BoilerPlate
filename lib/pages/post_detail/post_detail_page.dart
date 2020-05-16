import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/routes.dart';
import 'package:flutter_boilerplate/utils/translation.dart';

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamed(context, Routes.home),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(Translations.text('post_detail_page')),
            Text(
              'Current language: ' + Translations.trackingLanguage,
              style: TextStyle(fontSize: 30),
            ),
            Text(
              Translations.text('page_number', args: {'pageNumber': '1'}),
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
