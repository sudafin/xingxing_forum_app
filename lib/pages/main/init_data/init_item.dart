import 'package:flutter/material.dart';
import '../../home/home_page.dart';
import '../../group/group_page.dart';
import '../../message/message_page.dart';
import '../../profile/profile_page.dart';

List<Widget> pages = [
  HomePage(),
  GroupPage(),
  MessagePage(),
  ProfilePage(),
];

int unreadCount = 5; //未读消息数量
List<BottomNavigationBarItem> bottomBarItems = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
  BottomNavigationBarItem(icon: Icon(Icons.group), label: '社区'),
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



