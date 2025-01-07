import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/enum/page_type_enum.dart';
import 'package:xingxing_forum_app/pages/main/appbar_widget.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';
import 'package:xingxing_forum_app/model/event_model.dart';
import 'package:xingxing_forum_app/pages/home/follow_page.dart';
import 'package:xingxing_forum_app/pages/home/recommend_page.dart';
import 'package:xingxing_forum_app/pages/home/popular_page.dart';
import 'package:xingxing_forum_app/utils/log.dart';
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
  int currentIndex = 0;
  final PageController _pageController = PageController();
  List<Widget> pages = [
    FollowPage(),
    RecommendPage(),
    PopularPage(),
  ];
  @override
  Widget build(BuildContext context) {
  //监听页面切换事件
    eventBus.on<HomePageChangeEvent>().listen((event) {
      setState(() {
        currentIndex = event.homeIndex;      
        _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 1000), curve: Curves.bounceInOut);
      });
    });
    return
     PageView(
      controller: _pageController,
      children: pages,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
          // 发送菜单页面切换事件
          eventBus.fire(HomePageChangeEvent(homeIndex: index, menuIndex: currentIndex));
          Log.info("homePage fire :currentIndex: $currentIndex");
        });
      },
     );
  }
}

