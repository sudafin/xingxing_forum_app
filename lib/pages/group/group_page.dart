import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../enum/page_type_enum.dart';
import '../../store/store_viewmodel.dart';
import '../main/appbar_widget.dart';
import '../main/menu_drawer.dart';
import 'init_data.dart';
import '../error/error_page.dart';
import 'group_menu/favorite_recommend.dart';
import 'group_menu/online_game.dart';
import 'group_menu/single_game.dart';
import 'group_menu/iinternet_gossip.dart';
import 'group_menu/community_services.dart';
import 'group_menu/game_product.dart';
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
      children: [
         NavigationRail(
         //控制导航栏的宽度
           minWidth: 80,
           //控制导航栏的高度
           groupAlignment: -1.15,
            backgroundColor: context.watch<StoreViewModel>().theme == Brightness.light
                ? Color(0xFFF3F3F3)
                : Color.fromARGB(243, 74, 74, 74),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            //显示图标或者文字,或者两者都有,或者就显示图标
            labelType: NavigationRailLabelType.none,
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
        // VerticalDivider(
        //   color: Colors.red,
        //   thickness: 100,
        //   width: 10,
        // ),
        Expanded(
          child: GroupPageContent(index: _selectedIndex)
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
      0 => const FavoriteRecommend(),
      1 => const InternetGossip(),
      2 => const OnlineGame(),
      3 => const SingleGame(),
      4 => const CommunityServices(),
      5 => const GameProduct(),
      //没有的页面是错误页面
      _ => const ErrorPage(),
    };
      
  }
}

