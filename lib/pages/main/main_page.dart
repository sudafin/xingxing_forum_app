import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import 'init_data/init_item.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        //不显示未选中的标签
        showUnselectedLabels: false,
        currentIndex: currentPageIndex,
        items: BottomBarItem.bottomBarItems,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) { 
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
