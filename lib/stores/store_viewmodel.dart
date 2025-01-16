import 'package:flutter/material.dart';
class StoreViewModel extends ChangeNotifier{
   Brightness theme = Brightness.light;
   Future<void> changeTheme() async {
    theme = theme == Brightness.dark ? Brightness.light : Brightness.dark;
    notifyListeners();
   }
 
}