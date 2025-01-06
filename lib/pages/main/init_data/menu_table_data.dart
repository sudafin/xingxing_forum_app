import 'package:flutter/material.dart';

/// 菜单栏数据
class TabData {
  /// 导航数据构造函数
  const TabData({required this.index, required this.title, required this.icon});

  /// 导航标题
  final String title;

  /// 导航图标
  final IconData icon;

  /// 索引
  final int index;
}

/// 导航栏数据集合
const List<TabData> datas = <TabData>[
  TabData(index: 0, title: '收藏', icon: Icons.favorite),
  TabData(index: 1, title: '浏览历史', icon: Icons.history),
  TabData(index: 2, title: '设置', icon: Icons.settings),
  TabData(index: 3, title: '草稿', icon: Icons.edit),
  TabData(index: 4, title: '深色模式', icon: Icons.dark_mode),
  TabData(index: 5, title: '分享', icon: Icons.share),
  TabData(index: 6, title: '关于', icon: Icons.info),
  TabData(index: 7, title: '退出', icon: Icons.exit_to_app),
];

