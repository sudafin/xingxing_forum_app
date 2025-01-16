import 'package:flutter/material.dart';

class FollowNotifiedPage extends StatefulWidget {
  const FollowNotifiedPage({super.key});

  @override
  State<FollowNotifiedPage> createState() => _FollowNotifiedPageState();
}

class _FollowNotifiedPageState extends State<FollowNotifiedPage> {
  bool isFollow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新增关注',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 50,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 这里添加刷新逻辑
          await Future.delayed(Duration(seconds: 1)); // 模拟网络请求
          setState(() {
            // 更新数据
          });
        },
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile',
                  arguments: {'id': '123'});
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[400]!.withOpacity(0.3),
              radius: 20,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile',
                        arguments: {'id': '123'});
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '用户名',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '开始关注您了',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '48分钟前',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 70,
            height: 35,
            decoration: BoxDecoration(
              color: isFollow
                  ? Colors.grey[400]!.withOpacity(0.3)
                  : Colors.blue[400]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isFollow = !isFollow;
                });
              },
              child: isFollow
                  ? Text(
                      '已关注',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  : Text(
                      '回关',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
