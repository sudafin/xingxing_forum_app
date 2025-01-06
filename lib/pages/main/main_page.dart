import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import 'init_item.dart';


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
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 20,
        unselectedFontSize: 20,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      
    );
  }
}
