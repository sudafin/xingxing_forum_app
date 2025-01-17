import 'package:flutter/material.dart';

class ChatSettingPage extends StatefulWidget {
  const ChatSettingPage({super.key});

  @override
  State<ChatSettingPage> createState() => _ChatSettingPageState();
}

class _ChatSettingPageState extends State<ChatSettingPage> {
  bool isMute = false;
  bool isTop = false;
  bool isBlack = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          '聊天设置',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 50,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    int count = 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          //头像区域
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 15),
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              // 原本头像的的个数加最后一个邀请的图标
              children: List.generate(
                  count + 1,
                  (index) => index != count
                      ? Container(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                          child: Column(
                            children: [
                              //头像
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.network(
                                    'https://picsum.photos/200/300?random=1',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //昵称
                              Text(
                                '昵称',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  color: Color(0xFFF5F5F5),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '邀请好友',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        )),
            ),
          ),
          //聊天设置区域
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text('设置备注名'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text('查找聊天记录'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          //消息免打扰
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text('消息免打扰'),
              trailing: Switch(
                activeTrackColor: Colors.blue,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                // 去掉边框
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                value: isMute,
                onChanged: (bool value) {
                  setState(() {
                    isMute = !isMute;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text('置顶聊天'),
              trailing: Switch(
                activeTrackColor: Colors.blue,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                // 去掉边框
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                value: isTop,
                onChanged: (bool value) {
                  setState(() {
                    isTop = !isTop;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text('屏蔽消息'),
              trailing: Switch(
                activeTrackColor: Colors.blue,
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                // 去掉边框
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                value: isBlack,
                onChanged: (bool value) {
                  setState(() {
                    isBlack = !isBlack;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text('清空聊天记录'),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                title: Text('举报该用户'),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
