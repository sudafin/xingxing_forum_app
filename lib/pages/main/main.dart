import 'package:flutter/material.dart';
import 'init_item.dart';
import 'appbar_widget.dart';
import 'menu_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
static int currentPageIndex = 0;  
  @override
  Widget build(BuildContext context) {
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
