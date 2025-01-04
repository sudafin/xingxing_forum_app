import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/store/store_viewmodel.dart';
import 'package:xingxing_forum_app/widgets/menu_table_data.dart';

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
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '菜单',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // 使用 menu_table_data.dart 中的数据构建菜单项
          ...datas.map((TabData data) {
            if (data.index != 4) {
              return ListTile(
                leading: Icon(data.icon),
                title: Text(data.title),
                onTap: () {
                  // 处理菜单项点击
                  Navigator.pop(context); // 关闭抽屉
                  // 导航逻辑
                  // if (data.index == 0) {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePage()));
                  // }
                },
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              );
              //如果index为4则显示切换按钮
            } else if(data.index == 4){
              return ListTile(
                leading: Icon(data.icon),
                title: Text(data.title),
                onTap: () {
                  // 处理菜单项点击
                  Navigator.pop(context); // 关闭抽屉
                },
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
                    value: context.watch<StoreViewModel>().theme == Brightness.dark,
                    onChanged: (bool value) {
                      setState(() {
                        // 切换主题
                        context.read<StoreViewModel>().changeTheme();
                      });
                    },
                  ),
                ),
              );
            }else {
              // 不用设置
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
