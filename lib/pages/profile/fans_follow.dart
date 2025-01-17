import 'package:flutter/material.dart';

class FansFollowPage extends StatefulWidget {
  const FansFollowPage({super.key});

  @override
  State<FansFollowPage> createState() => _FansFollowPageState();
}

class _FansFollowPageState extends State<FansFollowPage>
    with SingleTickerProviderStateMixin {
  bool isFollow = false;
  late final TabController _tabController;
  final List<Tab> tabs = [
    Tab(text: '关注'),
    Tab(text: '粉丝'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          dividerColor: Colors.transparent,
          tabs: tabs,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
      body: Column(
        children: [
          // Tab页面
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFollowList(),
                _buildFansList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('     我的关注 (4)',style: TextStyle(fontSize: 14, color: Colors.black54),),
        Expanded(child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildItem();
          },
        ),),
      ],
    );
  }

  Widget _buildFansList() {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('     我的粉丝 (4)',style: TextStyle(fontSize: 14, color: Colors.black54),),
          Expanded(child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildItem();
            },
          ),),
        ],
      );
  }

  Widget _buildItem() {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          // 点击头像
          Navigator.pushNamed(context, '/profile');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://picsum.photos/200/300?random=1',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        '昵称',
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
      subtitle: Text(
        '粉丝',
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFF5F5F5),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              isFollow = !isFollow;
            });
          },
          child: Text(
            isFollow ? '取消关注' : '关注',
            style: TextStyle(
                fontSize: 12, color: isFollow ? Colors.blue : Colors.grey),
          ),
        ),
      ),
    );
  }
}
