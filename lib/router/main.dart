import 'package:flutter/material.dart';
import 'main_page.dart';
import 'deatail_page.dart';
import 'about_page.dart';
import 'router.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MainPage(), 不需要设置home如果有路由配置
      routes:{
        '/':(context) => RouterConstant.routerConstantMap['/']!(context),
        '/detail':(context) => RouterConstant.routerConstantMap['/detail']!(context),
        '/about':(context) => RouterConstant.routerConstantMap['/about']!(context),
      },
      initialRoute: '/',
    );
  }
}
