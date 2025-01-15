import 'package:flutter/material.dart';

class FollowNotifiedPage extends StatelessWidget {  
  const FollowNotifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('新增关注'),
      toolbarHeight: 50,
    ),
      backgroundColor: Color(0xFFF5F5F5),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildItem(context, index);
        },
      ),
    );
  }
  Widget _buildItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile',arguments: {'id': '123'});
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[400]!.withOpacity(0.3),
              radius: 20,
            ),
          ),
          Text('关注通知'),
        ],
      ),
    );
  }
}
