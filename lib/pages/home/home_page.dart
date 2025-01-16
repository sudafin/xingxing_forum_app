import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/enum/page_type_enum.dart';
import 'package:xingxing_forum_app/pages/main/appbar_widget.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';
import 'package:xingxing_forum_app/model/event_model.dart';
import 'package:xingxing_forum_app/pages/home/follow_page.dart';
import 'package:xingxing_forum_app/pages/home/recommend_page.dart';
import 'package:xingxing_forum_app/pages/home/popular_page.dart';
import 'package:xingxing_forum_app/stores/store_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarWidgetHome(pageType: PageType.home),
    drawer: MenuDrawer(),
    body: HomePageBody(),
    onDrawerChanged: (isOpened) {
      final store = Provider.of<StoreDrawer>(context, listen: false);
      store.setIsOpened(isOpened);
    },
  );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => HomePageBodyState();
}
class HomePageBodyState extends State<HomePageBody> {  
  int currentIndex = 0;
  final PageController _pageController = PageController();
  List<Widget> pages = [
    FollowPage(),
    RecommendPage(),
    PopularPage(),
  ];
  late final StreamSubscription<HomePageChangeEvent> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = eventBus.on<HomePageChangeEvent>().listen((event) {
      setState(() {
        currentIndex = event.homeIndex;      
        _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 100), curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();  
  }

  @override
  Widget build(BuildContext context) {
    return
     PageView(
      controller: _pageController,
      children: pages,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
          // 发送菜单页面切换事件
          eventBus.fire(HomePageChangeEvent(homeIndex: index, menuIndex: currentIndex));
        });
      },
     );
  }
}

