import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool isSignedIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('论坛任务'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('累计签到1天、连续签到1天'),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignedIn = !isSignedIn;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: isSignedIn ? Colors.grey[300] : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(isSignedIn ? '已签到' : '未签到'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('金币和N币可用于论坛中购买虚拟道具、使用特定功能,或在论坛商城中兑换礼品。'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Image.asset('assets/images/ban_ad.png', width: 40, height: 40),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('看视频免广告(限时)...'),
                      Text('看视频免除显示联盟广告,持续24小时',style: TextStyle(fontSize: 10),),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('去完成'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Image.asset('assets/images/n_icon.png', width: 40, height: 40),
                  SizedBox(width: 12),
                  Text('每天看两次视频(1)'),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('去完成'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

