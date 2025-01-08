import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../store/store_viewmodel.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool isShow = false;
  bool isAdd = false;
  bool isEmoji = false;
  bool isAlbum = false;
  bool isVideo = false;
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<StoreViewModel>().theme;
    final textColor = theme == Brightness.light ? Colors.black : Colors.white;
    final hintTextColor =
        theme == Brightness.light ? Colors.grey : Colors.grey[600];
    return Scaffold(
        appBar: AppBar(
          title: Text('发主题'),
          backgroundColor:
              theme == Brightness.light ? Colors.white : Colors.black,
          foregroundColor: textColor,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                // TODO: 实现发布主题的逻辑
              },
              child: Text(
                '发布',
                style: TextStyle(fontSize: 18, color: textColor),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      // TODO: 实现选择发布版块的逻辑
                    },
                    child: Row(
                      children: [
                        Text(
                          '选择发布模块',
                          style: TextStyle(fontSize: 20, color: hintTextColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: hintTextColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 20, color: Colors.grey[200]),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: '标题(必填)',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 20, color: hintTextColor),
                    ),
                    style: TextStyle(fontSize: 20, color: textColor),
                  ),
                  Divider(height: 10, color: Colors.grey[200]),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        hintText: '请输入内容',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 20, color: hintTextColor),
                      ),
                      style: TextStyle(fontSize: 20, color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  border: Border(
                    top: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isEmoji = !isEmoji;
                                isShow = isEmoji;
                                isAlbum = false;
                                isVideo = false;
                                isAdd = false;
                              });
                            },
                            icon: Image.asset(
                              'assets/images/emoji.png',
                              color: isEmoji ? Colors.blue : hintTextColor,
                              width: 40,
                              height: 35,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isAlbum = !isAlbum;
                                //这里isShow要根据isAlbum的值来决定,不能先写
                                isShow = isAlbum;
                                isEmoji = false;
                                isVideo = false;
                                isAdd = false;
                              });
                            },
                            icon: Image.asset(
                              'assets/images/album.png',
                              color: isAlbum ? Colors.blue : hintTextColor,
                              width: 40,
                              height: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isVideo = !isVideo;
                                isShow = isVideo;
                                isEmoji = false;
                                isAlbum = false;
                                isAdd = false;
                              });
                            },
                            icon: Image.asset(
                              'assets/images/video.png',
                              color: isVideo ? Colors.blue : hintTextColor,
                              width: 40,
                              height: 40,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isAdd = !isAdd;
                                isShow = isAdd;
                                isEmoji = false;
                                isAlbum = false;
                                isVideo = false;
                              });
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 30,
                              color: isAdd ? Colors.blue : hintTextColor,
                            )),
                      ],
                    ),
                    if (isShow)
                      Container(
                        height: SizeFit.screenHeight * 0.3,
                        child: PageView(
                          children: [
                            if (isEmoji) EmojiPage(),
                            if (isAlbum) AlbumPage(),
                            if (isVideo) VideoPage(),
                            if (isAdd) AddPage(),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
//TODO: 实现底部页面
class EmojiPage extends StatelessWidget {
  const EmojiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[300],
    );
  }
}

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[300],
    );
  }
}

class AddPage extends StatelessWidget {
  const AddPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}
