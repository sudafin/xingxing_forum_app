import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../store/store_viewmodel.dart';
import '../../../enum/page_type_enum.dart';

class AppBarWidgetHome extends StatelessWidget implements PreferredSizeWidget {
  final PageType pageType;
  const AppBarWidgetHome({super.key, required this.pageType});

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    if (pageType==PageType.message) {
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
            color: context.watch<StoreViewModel>().theme == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
        ),
        actions: [
          // 添加好友
          IconButton(
            onPressed: () {
              //跳转添加好友页面
              Navigator.pushNamed(context, '/add_friend');
            },
            icon: Icon(Icons.person_add, color: Colors.blue, size: 30),
            alignment: Alignment.centerRight,
          ),
        ],
      );
    } else {
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
        title: (pageType==PageType.group) ? SearchBar() : null,
        //听歌图标和邮件图标太靠右
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/task');
              },
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.blue,
                size: 30,
              ),
            ),
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
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        width: 300,
        height: 40,
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
