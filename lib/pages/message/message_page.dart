import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/enum/page_type_enum.dart';
import 'package:xingxing_forum_app/pages/main/appbar_widget.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';
import 'package:xingxing_forum_app/pages/message/chat_screen.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetHome(pageType: PageType.message),
      drawer: MenuDrawer(),
      body: MessagePageBody(),
    );
  }
}

class MessagePageBody extends StatefulWidget {
  const MessagePageBody({super.key});

  @override
  State<MessagePageBody> createState() => _MessagePageBodyState();
}

class _MessagePageBodyState extends State<MessagePageBody> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildBody(constraints.maxHeight)
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        _buildActionButton('赞或收藏', 'assets/images/collection.png', () {
          Navigator.pushNamed(context, '/favorite_notified');
        }, 0),
        _buildActionButton('新增关注', 'assets/images/person.png', () {
          Navigator.pushNamed(context, '/follow_notified');
        }, 1),
        _buildActionButton('评论或@', 'assets/images/notification.png', () {
          Navigator.pushNamed(context, '/comment_notified');
        }, 2),
      ],
    ));
  }

  Widget _buildActionButton(
      String title, String iconPath, Function onTap, int index) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // 背景层
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: index == 0
                    ? Color(0xFF76ACF9).withOpacity(0.2)
                    : index == 1
                        ? Color(0xFF928EF9).withOpacity(0.2)
                        : Color(0xFFF57476).withOpacity(0.2), // 背景颜色
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 5),
              ),
            ),
            // 图片层
            Image.asset(iconPath, width: 36, height: 36),
            // 右上角显示数字
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '99+',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
      )
    );
  }

  Widget _buildBody(double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          //外部已经有refreshIndicator，所以内部不需要再有
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildMessageItem(context, index);
          }),
    );
  }

  Widget _buildMessageItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatScreen(id: index)));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          children: [
            //头像
            CircleAvatar(
              backgroundColor: Colors.grey[400]!.withOpacity(0.3),
              radius: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    'https://picsum.photos/200/300?random=1',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  '联系人名字',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                subtitle: Text(
                  '消息',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '2025-01-13 10:00',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    // 右上角显示数字
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('99+',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
