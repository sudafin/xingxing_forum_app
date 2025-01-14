import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final int id;
  const ChatScreen({super.key, required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isMe: true));
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.insert(0, ChatMessage(text: '这是一条固定的回复消息', isMe: false));
      });
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: '发送消息'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('聊天')),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text('机')),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(isMe ? '我' : '机器人', style: Theme.of(context).textTheme.bodyMedium),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
          if (isMe)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(child: Text('我')),
            ),
        ],
      ),
    );
  }
}