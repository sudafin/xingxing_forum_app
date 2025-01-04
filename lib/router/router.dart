import 'package:flutter/material.dart';
import 'main_page.dart';
import 'deatail_page.dart';
import 'about_page.dart';

class RouterConstant{
  static final Map<String,WidgetBuilder> routerConstantMap = {
  '/':(context) => const MainPage(),
  '/detail':(context) => const DetailPage(),
  '/about':(context) => const AboutPage(),
  };
}
