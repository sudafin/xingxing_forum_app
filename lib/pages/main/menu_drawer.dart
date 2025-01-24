import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/stores/store_viewmodel.dart';
import 'package:xingxing_forum_app/pages/main/init_data/menu_table_data.dart';
import 'package:xingxing_forum_app/widgets/share_widget.dart';
import 'package:xingxing_forum_app/pages/login/sign_spash_screen.dart';
import 'package:xingxing_forum_app/pages/menu/test_page.dart';
import 'package:hive/hive.dart';

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
            context.read<StoreViewModel>().theme == Brightness.dark
                ? Colors.black
                : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context, index) {
            final data = datas[index];
            if (data.index != 4 && data.index != 7) {
              return SizedBox(
                    child: 
                    Column(
                      children: [
                        ListTile(
                      leading: Icon(data.icon,size: 20,),
                      title: Text(data.title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400)), // 设置字体为粗体
                      onTap: () {
                        // 关闭抽屉
                        Navigator.pop(context);
                        // 导航逻辑
                        navigatorIndex(data.index, context);
                      },
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                    // 如果index为3或5则显示分割线
                    data.index == 3 || data.index == 5 ? Divider(
                      color: Colors.grey[300],
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10,
                    ) : SizedBox.shrink(),
                  ],
                ));
            }
            //如果index为4的深色模式尾部则需要显示切换按钮
            else if (data.index == 4) {
              return Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListTile(
                      leading: Icon(data.icon,size: 20,),
                      title: Text(data.title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400)), // 设置字体为粗体
                      //index为4时设置切换按钮
                      trailing:Switch(
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          // 去掉边框
                          trackOutlineColor:
                              WidgetStateProperty.all(Colors.transparent),
                          value: context.watch<StoreViewModel>().theme ==
                              Brightness.dark,
                          onChanged: (bool value) {
                            context.read<StoreViewModel>().changeTheme();
                          },
                        ),
                    ));
            } 
            //退出按钮需要设置按钮
            else if (data.index == 7) {
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
                          Border.all(color: context.watch<StoreViewModel>().theme == Brightness.dark ? Colors.white24 : Colors.black12, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // 退出登录
                            Navigator.pop(context);
                            //TODO退出登录
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text('退出登录'),
                              content: Text('确定要退出登录吗？'),
                              actions: [
                                TextButton(onPressed: () {Navigator.pop(context);}, child: Text('取消')),
                                TextButton(onPressed: () async {
                                  //退出登录
                                  Navigator.pop(context);
                                  //清空token
                                  final userBox = await Hive.openBox('user');
                                  userBox.clear();
                                  //跳转到登录页面
                                  Navigator.pushNamed(context, '/sign_in');
                                }, child: Text('确定')),
                              ],
                            ));
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
          },
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
  } else if (index == 8) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignSplashScreen()));
  }
}
