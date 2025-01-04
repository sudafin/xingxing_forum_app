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

/// 通过 TabBar 导航栏切换展示的主要内容
/// 用于在 TabBarView 中显示的组件
class TabContent extends StatelessWidget {
  const TabContent({super.key, required this.data});

  /// 根据该数据条目生成组件
  final TabData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      /// 设置 20 像素边距
      margin: EdgeInsets.all(20),
      /// 设置阴影
      elevation: 10,
      /// 卡片颜色黑色
      color: Colors.black,
      /// 卡片中的元素居中显示
      child: Center(
        /// 垂直方向的线性布局
        child: Column(
          /// 在主轴 ( 垂直方向 ) 占据的大小
          mainAxisSize: MainAxisSize.min,
          /// 居中显示
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// 设置图标
            Icon(data.icon, size: 128.0, color: Colors.green),
            /// 设置文字
            Text(data.title,
                style: TextStyle(color: Colors.yellow, fontSize: 20)),
          ],
        ),
        //在末尾添加一个箭头图标
      ),
      
    
    );
  }
}
