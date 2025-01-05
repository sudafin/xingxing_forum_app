import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/enum/page_type_enum.dart';
import 'package:xingxing_forum_app/pages/main/appbar_widget.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarWidgetHome(pageType: PageType.home),
    drawer: MenuDrawer(),
    body: HomePageBody(),
  );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => HomePageBodyState();
}
class HomePageBodyState extends State<HomePageBody> {  
  @override
  Widget build(BuildContext context) {
    return Text("wenben");
  }
}
