import 'package:flutter/material.dart';

class ChatSettingPage extends StatefulWidget {
  const ChatSettingPage({super.key});

  @override
  State<ChatSettingPage> createState() => _ChatSettingPageState();
}

class _ChatSettingPageState extends State<ChatSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天设置',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        toolbarHeight: 50,
      ),
      body: Container(
        child: Text('聊天设置'),
      ),
    );
  }
}

