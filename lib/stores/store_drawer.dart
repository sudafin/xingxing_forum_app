import 'package:flutter/material.dart';

class StoreDrawer extends ChangeNotifier {
  bool _isOpened = false;

  bool get isOpened => _isOpened;

  void setIsOpened(bool isOpened) {
    _isOpened = isOpened;
    notifyListeners();
  }
}
