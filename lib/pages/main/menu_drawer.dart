import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/store/store_viewmodel.dart';
import 'package:xingxing_forum_app/pages/main/init_data/menu_table_data.dart';
import 'package:xingxing_forum_app/pages/menu/share/share_widget.dart';

@immutable
/// 菜单栏
class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  MenuDrawerState createState() => MenuDrawerState();
}

class MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
  //DrawerHeader外边框是黑线,需要将DividerThemeData设置为透明
    return Theme(
      data: Theme.of(context)
          .copyWith(dividerTheme: DividerThemeData(color: Colors.transparent)),
      child: Drawer(
        backgroundColor:
            context.watch<StoreViewModel>().theme == Brightness.dark
                ? Colors.black
                : Color.fromARGB(255, 249, 249, 249),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //菜单头
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: context.watch<StoreViewModel>().theme == Brightness.dark
                    ? Colors.black
                    : Colors.lightBlue[400],
              ),
              child: InkWell(
                onTap: () {
                  // 头像点击跳转逻辑
                  Navigator.pop(context); // 关闭抽屉
                  // 导航逻辑
                  Navigator.pushNamed(context, '/profile');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '用户名',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal, // 设置字体为粗体
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 使用 menu_table_data.dart 中的数据构建菜单项
            ...datas.map((TabData data) {
              if (data.index != 4 && data.index != 7) {
                return Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: context.watch<StoreViewModel>().theme ==
                              Brightness.dark
                          ? const Color.fromARGB(93, 119, 119, 119)
                          : Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(data.icon),
                      title: Text(data.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w400)), // 设置字体为粗体
                      onTap: () {
                        // 关闭抽屉
                        Navigator.pop(context);
                        // 导航逻辑
                        navigatorIndex(data.index, context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ));
                //如果index为4的深色模式尾部则需要显示切换按钮
              } else if (data.index == 4) {
                return Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: context.watch<StoreViewModel>().theme ==
                              Brightness.dark
                          ? const Color.fromARGB(93, 119, 119, 119)
                          : Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(data.icon),
                      title: Text(data.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w400)), // 设置字体为粗体
                      //index为4时设置切换按钮
                      trailing: Container(
                        //调整位置
                        constraints: BoxConstraints(maxWidth: 100),
                        child: Switch(
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          // 去掉边框
                          trackOutlineColor:
                              WidgetStateProperty.all(Colors.transparent),
                          value: context.watch<StoreViewModel>().theme ==
                              Brightness.dark,
                          onChanged: (bool value) {
                            setState(() {
                              // 切换主题
                              context.read<StoreViewModel>().changeTheme();
                            });
                          },
                        ),
                      ),
                    ));
                //退出按钮需要设置按钮
              } else if (data.index == 7) {
                // 退出按钮
                return Container(
                    margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
                    decoration: BoxDecoration(
                      color: context.watch<StoreViewModel>().theme ==
                              Brightness.dark
                          ? const Color.fromARGB(93, 119, 119, 119)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      //设置border
                      border:
                          Border.all(color: Colors.lightBlue[100]!, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // 退出登录
                            Navigator.pop(context);
                            //TODO退出登录
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            size: 24,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          '退出登录',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w400),
                        ), // 设置字体为粗体
                      ],
                    ));
              } else {
                // 不用设置
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

//设置导航
void navigatorIndex(int index, BuildContext context) {
  if (index == 0) {
    Navigator.pushNamed(context, '/favorite');
  } else if (index == 1) {
    Navigator.pushNamed(context, '/history');
  } else if (index == 2) {
    Navigator.pushNamed(context, '/settings');
  } else if (index == 3) {
    Navigator.pushNamed(context, '/drafts');
  } else if (index == 5) {
    //设置底部弹窗
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ShareWidget();
      },
    );
  } else if (index == 6) {
    Navigator.pushNamed(context, '/about');
  }
}
