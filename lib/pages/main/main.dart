import 'package:flutter/material.dart';
import 'init_item.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/menu_drawer.dart';
import '../../enum/page_type_enum.dart';

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
      appBar: AppBarWidgetHome(),
      drawer: MenuDrawer(),
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
