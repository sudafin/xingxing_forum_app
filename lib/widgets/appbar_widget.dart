import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/store_viewmodel.dart';
import '../../pages/main/main.dart';

class AppBarWidgetHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidgetHome({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    if (MainPageState.currentPageIndex != 2) {
      return AppBar(
        //加上border
        shape: Border(
          bottom: BorderSide(color: Color(0xFFF3F3F3), width: 1),
        ),
        //点击推拉出菜单栏
        leading: IconButton(
          onPressed: () {
            //打开菜单栏
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.blue,
            size: 30,
          ),
        ),
        leadingWidth: 60,
        //如果是群组页面index为1，则显示搜索框
        title: (MainPageState.currentPageIndex == 1) ? SearchBar() : null,
        //听歌图标和邮件图标太靠右
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () {
                //跳转日历页面
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()));
              },
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () {
                //跳转通知页面
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
              },
              icon: Icon(
                Icons.notifications,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            //打开菜单栏
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.blue, size: 30),
          alignment: Alignment.centerLeft,
        ),
        leadingWidth: 60,
        title: Text(
          '消息',
          style: TextStyle(
            color: context.watch<StoreViewModel>().theme == Brightness.dark ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
        ),
        actions: [
          // 添加好友
          IconButton(
            onPressed: () {
              //跳转添加好友页面
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendPage()));
            },
            icon: Icon(Icons.person_add, color: Colors.blue, size: 30),
            alignment: Alignment.centerRight,
          ),
        ],
      );
    }
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        width: 280,
        height: 36,
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(5),
        ),
        //中间有个搜索图标
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.search,
              color: Color.fromARGB(214, 141, 141, 141),
              size: 21,
            ),
            SizedBox(
              width: 10,
            ),
            //跟图标对齐
            Text(
              '搜索',
              style: TextStyle(
                  color: Color.fromARGB(214, 141, 141, 141),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
