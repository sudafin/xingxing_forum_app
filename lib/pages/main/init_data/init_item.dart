import 'package:flutter/material.dart';
import '../../home/home_page.dart';
import '../../group/group_page.dart';
import '../../message/message_page.dart';
import '../../profile/profile_page.dart';
import '../../../widgets/post_page/post_page.dart';

List<Widget> pages = [
  HomePage(),
  GroupPage(),
  PostPage(),
  MessagePage(),
  ProfilePage(),
];


class BottomBarItem {
  static List<BottomNavigationBarItem> bottomBarItems =[];
  static void initialize(BuildContext context){
  int unreadCount = 5; //未读消息数量
  bottomBarItems = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页',),
  BottomNavigationBarItem(icon: Icon(Icons.group), label: '社区',),
  BottomNavigationBarItem(
    icon: Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.blue ,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: IconButton(icon: Icon(Icons.add,color: Colors.white,),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPage()));
      },),),
    ),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: Stack(
      children: [
        Icon(Icons.message),
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    ),
    label: '消息',
  ),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];
}
}


List<String?> tabTitles = ['关注', '推荐', '热帖'];