import 'package:flutter/material.dart';

import '../../constants/images.dart';


class NoDataView extends StatelessWidget {
 final String noDataText;

  const NoDataView({this.noDataText = 'No Data'});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(Images.logo),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              noDataText,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}