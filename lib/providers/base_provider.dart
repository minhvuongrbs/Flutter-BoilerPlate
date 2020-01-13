import 'package:flutter/material.dart';

enum ViewStatus { Loading, Ready }

class BaseProvider extends ChangeNotifier {
  ViewStatus _status;

  ViewStatus get viewStatus => _status;

  void setStatus(ViewStatus status) {
    _status = status;
    notifyListeners();
  }
}
