import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'store/store_viewmodel.dart';
import 'router/router.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StoreViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 明亮模式
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 60,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.light(
          primary: Colors.teal, // 主颜色，用于滑块
          surface: Colors.white, // 卡片颜色
        ),
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xFFF3F3F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.teal[200]!; // 打开时轨道颜色
            }
            return Colors.grey[200]!; // 关闭时轨道颜色
          }),
          thumbColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white; // 打开时滑块颜色
            }
            return Colors.grey[200]!; // 关闭时滑块颜色
          }),
        ),
      ),

      // 深色模式
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 60,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.dark(
          primary: Colors.teal, // 主颜色，用于滑块
          surface: Colors.grey[800]!, // 卡片颜色
        ),
        scaffoldBackgroundColor: Color(0xFF121212),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.teal; // 打开时轨道颜色
            }
            return Colors.grey; // 关闭时轨道颜色
          }),
          thumbColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white; // 打开时滑块颜色
            }
            return Colors.grey[400]!; // 关闭时滑块颜色
          }),
        ),
      ),
      themeMode: context.watch<StoreViewModel>().theme == Brightness.light
          ? ThemeMode.light
          : ThemeMode.dark,
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('zh', 'CN'),
      routes: RouterConstant.routerConstantMap,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) { 
        return MaterialPageRoute(builder: (context) => RouterConstant.routerConstantMap[settings.name]!(context));
      },
    );
  }
}
