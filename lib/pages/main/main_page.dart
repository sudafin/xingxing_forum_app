import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import 'init_data/init_item.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/stores/store_drawer.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static int currentPageIndex = 0;  
  @override
  Widget build(BuildContext context) {
    SizeFit.initialize(context);
    BottomBarItem.initialize(context);
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: AnimatedCrossFade(
        duration: context.watch<StoreDrawer>().isOpened
            ? Duration(milliseconds: 0)
            : Duration(milliseconds: 300),
        crossFadeState: context.watch<StoreDrawer>().isOpened
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: SizedBox.shrink(),  // 隐藏状态
        secondChild: SizedBox(
          height: 70,
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: OverflowBox(
              maxHeight: 70,
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                showUnselectedLabels: false,
                currentIndex: currentPageIndex,
                items: BottomBarItem.bottomBarItems,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                unselectedFontSize: 10,
                iconSize: 22,
                onTap: (index) {
                  setState(() {
                  // 发帖页面不要通过转换来切换,通过点击来跳转
                   if(index != 2){
                    currentPageIndex = index;
                   }
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
