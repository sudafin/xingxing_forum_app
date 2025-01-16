import 'package:flutter/material.dart';
import '../../widgets/post_detail_page.dart';

class FavoriteNotifiedPage extends StatefulWidget {
  const FavoriteNotifiedPage({super.key});

  @override
  State<FavoriteNotifiedPage> createState() => _FavoriteNotifiedPageState();
}

class _FavoriteNotifiedPageState extends State<FavoriteNotifiedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '收到的点赞和收藏',
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
      margin: EdgeInsets.all(10),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(
                          imageCount: 1,
                          category: '1',
                          interactions: {'1': 1},
                          postId: '123',
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '用户名',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            '点赞了你的帖子/评论',
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
                      SizedBox(height: 10),
                      //被点赞的帖子
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey[400]!,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          '查看查查哈查哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈草草草草',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                      imageCount: 1,
                      category: '1',
                      interactions: {'1': 1},
                      postId: '123',
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
