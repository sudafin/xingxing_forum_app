import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../enum/page_type_enum.dart';
import '../../store/store_viewmodel.dart';
import '../main/appbar_widget.dart';
import '../main/menu_drawer.dart';
import 'init_data.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupNav.initialize(context);
    return Scaffold(
      appBar: AppBarWidgetHome(pageType: PageType.group),
      drawer: MenuDrawer(),
      body: GroupPageBody(),
      backgroundColor: context.watch<StoreViewModel>().theme == Brightness.dark ? Colors.black : Colors.white,
    );
  }
}

class GroupPageBody extends StatefulWidget {
  const GroupPageBody({super.key});

  @override
  State<GroupPageBody> createState() => _GroupPageBodyState();
}

class _GroupPageBodyState extends State<GroupPageBody> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
    color: context.watch<StoreViewModel>().theme == Brightness.light
              ? Color.fromARGB(255, 238, 238, 238)
              : Color.fromARGB(243, 249, 222, 222),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         NavigationRail(
            backgroundColor: context.watch<StoreViewModel>().theme == Brightness.light
                ? Color(0xFFF3F3F3)
                : Color.fromARGB(243, 74, 74, 74),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            selectedIconTheme: IconThemeData(color: Colors.black),
            unselectedIconTheme: IconThemeData(color: Colors.transparent),
            selectedLabelTextStyle: TextStyle(
              color: context.watch<StoreViewModel>().theme == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            unselectedLabelTextStyle: TextStyle(color: Colors.grey),
            destinations: GroupNav.groupNavList,
            useIndicator: true,
            indicatorColor: context.watch<StoreViewModel>().theme == Brightness.light
                ? Colors.white
                : Colors.black,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: GroupPageContent(index: _selectedIndex),
          ),
        ),
      ],
    ),
    );
  }
} 

class GroupPageContent extends StatelessWidget {
  final int index;
  const GroupPageContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return switch(index){
      0 => Center(child: Text('推荐/精华')),
      1 => Center(child: Text('网事杂谈')),
      2 => Center(child: Text('网络游戏')),
      3 => Center(child: Text('单机游戏')),
      4 => Center(child: Text('社区事务')),
      _ => Center(child: Text('其他')),
    };
      
  }
}

