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
  bool isSave = false;
  final TextEditingController _remarkController = TextEditingController();

  //TODO 这里需要拿到当前的名字做参数,这里等网络请求再做
  void _showRemarkDialog(String ? name,bool isRemark) {
    // 初始化isSave状态
    isSave = _remarkController.text.isNotEmpty;
    _remarkController.text = name ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Column(
                children: [
                  Text( isRemark ? '设置备注名' : '编辑举报信息',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  Text(isRemark ? '备注名长度为1-10个字符' : '举报信息长度为1-100个字符',
                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
              content: TextField(
                decoration: InputDecoration(
                  hintText: isRemark ? '请输入备注名' : '请输入举报信息',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                  isDense: true,
                  counterStyle: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                maxLength: isRemark ? 10 : 100,
                maxLines: isRemark ? 1 : null,
                minLines: isRemark ? 1 : null,
                keyboardType: isRemark ? TextInputType.text : TextInputType.multiline,
                textInputAction: isRemark ? TextInputAction.done : TextInputAction.newline,
                controller: _remarkController,
                onChanged: (value) {
                  setState(() {
                    isSave = value.isNotEmpty;
                  });
                },
              ),
              contentPadding: EdgeInsets.all(10),
              actionsPadding: EdgeInsets.zero,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    if (isSave) {
                      String remark = _remarkController.text;
                      print('保存备注名: $remark');
                      Navigator.pop(context);
                    }
                  },
                  child: Text('添加',
                      style:
                          TextStyle(color: isSave ? Colors.blue : Colors.grey)),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
    int count = 1;
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
                      ? GestureDetector(
                          onTap: () {
                            // 点击头像
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 10, top: 10),
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
                          ))
                      : GestureDetector(
                          onTap: () {
                            // 点击邀请好友
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 10, left: 10, top: 10),
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
                          ))),
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
              // 点击设置备注名
              onTap: () => _showRemarkDialog('昵称', true),
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
              onTap: () {
                //弹窗确认是否清空
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text('清空聊天记录',
                        style: TextStyle(fontSize: 14)),
                    actionsPadding: EdgeInsets.zero,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('取消'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('确定'),
                      ),
                    ],
                  ),
                );
              },
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
              onTap: () {
                _showRemarkDialog(null, false);
              },
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
