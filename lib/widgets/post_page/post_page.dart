import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../../store/store_viewmodel.dart';
import 'emoji_page.dart';
import 'image_page.dart';
import 'video_page.dart';
import 'additional_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final List<String> selectedImages = [];
  final List<Map<String, String>> selectedVideos = [];
  bool isShow = false;
  bool isAdd = false;
  bool isEmoji = false;
  bool isAlbum = false;
  bool isVideo = false;
  String selectedModule = '请选择发布版块';
  void _insertEmoji(String emoji) {
    //获取当前内容框中的的全部文本
    final text = _contentController.text;
    //获取当前光标所在位置,也就是我们要插入的位置,其中selection.start是开始位置,selection.end是结束位置
    final selection = _contentController.selection;
    //然后在光标当前位置上插入想要的数据,比如emoji,原本的text是'123' 如果在1和2的中间插入那么newText就是'1emoji23'
    final newText = text.replaceRange(selection.start, selection.end, emoji);
    //然后把文本替换为新的文本和然后设置替换后的光标位置
    _contentController.value = TextEditingValue(
      //设置新的文本
      text: newText,
      //插入emoji后光标位置,collapsed用于插入数据后光标显示的位置
      selection: TextSelection.collapsed(
        //baseOffset是光标位置加上emoji的长度
        offset: selection.baseOffset + emoji.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<StoreViewModel>().theme;
    final textColor = theme == Brightness.light ? Colors.black : Colors.white;
    final hintTextColor =
        theme == Brightness.light ? Colors.grey : Colors.grey[600];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('提示'),
                        content: Text('是否需要暂时存草稿箱里？'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/main');
                              },
                              child: Text('取消')),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/main');
                              },
                              child: Text('确定')),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('发主题'),
          backgroundColor:
              theme == Brightness.light ? Colors.white : Colors.black,
          foregroundColor: textColor,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: theme == Brightness.light
                            ? Colors.white
                            : Colors.black,
                        title: Text('发布主题'),
                        content: Text('确定要发布主题吗？'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('取消')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('确定')),
                        ],
                      );
                    });
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
                      //form表单
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('选择发布版块'),
                              content: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                hint: Text('请选择发布版块'),
                                value: selectedModule,
                                items: ['请选择发布版块', '版块1', '版块2', '版块3']
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedModule = value!;
                                  });
                                },
                              ),
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Text(
                          selectedModule,
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
                            if (isEmoji)
                              EmojiPage(onEmojiSelected: _insertEmoji),
                            if (isAlbum)
                              AlbumPage(selectedImages: selectedImages),
                            if (isVideo)
                              VideoPage(selectedVideos: selectedVideos),
                            if (isAdd) const AdditionalPage(),
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
