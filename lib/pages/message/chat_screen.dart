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
  bool isShow = true;
  bool isEmoji = false;
  bool isAdd = false;
  //listview的滚动控制器,用来拉动到最新消息
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(_messages.length, ChatMessage(text: text, isMe: true, time: DateTime.now().toLocal()));
    });
    //拉动到最新消息
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.insert(_messages.length, ChatMessage(text: '这是一条固定的回复消息', isMe: false));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      //listview的滚动控制器,拉动到ListView的底部
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        leadingWidth: 200,
        leading: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[400]!.withOpacity(0.3),
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.network(
                        'https://picsum.photos/200/300?random=1',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '张三',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Container(
            color: Color(0xFFFAFAFA),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: isShow ? 1 : 2,
              child: TextField(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                //maxLines为null表示显示无限行, 1表示显示1行,如果大于1行就滚动显示
                maxLines: isShow ? 1 : 5,
                minLines: 1,
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: '发送消息',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
                  filled: true,
                  fillColor: Color(0xFFFFFFFF),
                  isDense: true,
                ),
                onChanged: (value) {
                  setState(() {
                    isShow = !value.isNotEmpty;
                  });
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      size: 30,
                      color: Colors.grey[500],
                    )),
                isShow
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle_outline,
                          size: 30,
                          color: Colors.grey[500],
                        ))
                    : TextButton(
                        onPressed: _textController.text.isEmpty
                            ? null
                            : () {
                                setState(() {
                                  isShow = true;
                                  _handleSubmitted(_textController.text);
                                  _textController.clear();
                                });
                              },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('发送',
                                style: TextStyle(color: Colors.white)))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime? time;

  const ChatMessage({super.key, required this.text, required this.isMe, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          if (time != null)
            Text(time.toString(), style: TextStyle(color: Colors.grey[500])),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    child: Text('机'),
                    radius: 25,
                  ),
                ),
              Flexible(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    isMe
                        ? SizedBox.shrink()
                        : Text('机器人',
                            style: TextStyle(color: Colors.grey[600])),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(text,
                          style: TextStyle(
                              color: isMe ? Colors.white : Colors.black)),
                    ),
                  ],
                ),
              ),
              if (isMe)
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    child: Text('我'),
                    radius: 25,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
