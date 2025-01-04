import 'package:flutter/material.dart';
class StoreViewModel extends ChangeNotifier{
   Brightness theme = Brightness.light;
   Brightness changeTheme(){
    theme = theme == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
    return theme;
   }
 
}