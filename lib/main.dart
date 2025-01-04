import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'pages/main/main.dart';
import 'store/store_viewmodel.dart';
void main(List<String> args) {
  runApp(
  ChangeNotifierProvider(create: (context) => StoreViewModel(),
  child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //主题颜色切换, 组件不能自定义设置背景颜色,不然深色/亮色模式失效, 所以一些不需要深色模式的页面我们就需要单独设置背景颜色
      brightness: context.watch<StoreViewModel>().theme,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),
        centerTitle: true,
        // 去掉阴影
        elevation: 0, 
        toolbarHeight: 60,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      //整体颜色
      scaffoldBackgroundColor: Color(0xFFFFFFFF),
      //输入框颜色
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFFF3F3F3),
        //输入框圆角
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        
      ),
    ),
      home:MainPage(),
           supportedLocales: [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,  
      ],
      locale: Locale('zh', 'CN'),
    );
  }
}
