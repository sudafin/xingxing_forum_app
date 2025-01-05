import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/enum/page_type_enum.dart';
import 'package:xingxing_forum_app/pages/main/appbar_widget.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取当前路由名称
    final routeName = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      //如果是通过push到profile页面，则显示返回按钮
      appBar: routeName == '/profile'
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // 返回上一页
                },
              ),
              title: Text('我的', style: TextStyle(color: Colors.white)),
            )
          : AppBarWidgetHome(pageType: PageType.profile),
      drawer: routeName == '/profile' ? null : MenuDrawer(),
      body: const ProfilePageBody(),
    );
  }
}

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('我的'),
    );
  }
}
