import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'stores/store_viewmodel.dart';
import 'stores/store_drawer.dart';
import 'router/router.dart';
import 'pages/screen/splash_screen.dart';   
import 'pages/main/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main(List<String> args) async {
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StoreViewModel()),
        ChangeNotifierProvider(create: (context) => StoreDrawer()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 设置启动页是否已经显示,不然热更新会进入,或者深色模式也会进入
  bool hasShownSplash = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      // 明亮模式
      theme: ThemeData(
        fontFamily: 'PingFangSC-Regular',
        brightness: Brightness.light,
        //设置appbar的主题
        appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.blue),
        //滑动时颜色无需变化
        scrolledUnderElevation: 0,
        color: context.watch<StoreViewModel>().theme == Brightness.light
                ?  Color(0xFFFFFFFF):Color.fromARGB(243, 74, 74, 74),
        //appbar字体颜色
          titleTextStyle: TextStyle(
            color: context.watch<StoreViewModel>().theme == Brightness.light
                ? Color.fromARGB(243, 74, 74, 74)
                : Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        //组件颜色设置
        colorScheme: ColorScheme.light(
          primary: Colors.blue, // 主颜色，用于滑块
          surface: Colors.white, // 卡片颜色
          //显示文本字体颜色
          onSurface: context.watch<StoreViewModel>().theme == Brightness.light
              ? Colors.black
              : Color(0xFFF3F3F3),
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
      //启动页5s然后跳转到main页
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 0), () {
          hasShownSplash = true; // 设置状态为已显示
          return const MainPage();
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !hasShownSplash) {
            return const SplashScreen();
          } else {
            return AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 500),
              child: snapshot.data as Widget,
            );
          }
        },
      ),
    );     
  }
}
