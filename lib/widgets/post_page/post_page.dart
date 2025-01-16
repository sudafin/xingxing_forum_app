import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../../stores/store_viewmodel.dart';
import 'image_page.dart';
import 'video_page.dart';
import 'additional_page.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _emojiScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final List<String> selectedImages = [];
  final List<Map<String, String>> selectedVideos = [];
  bool isShow = false;
  bool isAdd = false;
  bool isEmoji = false;
  bool isAlbum = false;
  bool isVideo = false;
  String selectedModule = '请选择发布版块';


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
                          style: TextStyle(fontSize: 16, color: hintTextColor),
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
                      hintStyle: TextStyle(fontSize: 16, color: hintTextColor),
                    ),
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                  Divider(height: 10, color: Colors.grey[200]),
                  Expanded(
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isEmoji = false;
                          isAlbum = false;
                          isVideo = false;
                          isAdd = false;
                        });
                      },
                      focusNode: _focusNode,
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        hintText: '请输入内容',
                        border: InputBorder.none,
                        hintStyle:
                            TextStyle(fontSize: 16, color: hintTextColor),
                      ),
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _focusNode.unfocus();
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
                              _focusNode.unfocus();
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
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: isEmoji || isAlbum || isVideo || isAdd 
                          ? SizeFit.screenHeight * 0.3 
                          : 0,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: PageView(
                          children: [
                            if (isEmoji)
                              _buildEmojiPicker(),
                            if (isAlbum)
                              AlbumPage(selectedImages: selectedImages),
                            if (isVideo)
                              VideoPage(selectedVideos: selectedVideos),
                            if (isAdd) const AdditionalPage(),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ));
  }
    Widget _buildEmojiPicker() {
    return isEmoji ? SizedBox(
      height: 250,
      child: EmojiPicker(
        textEditingController: _contentController,
        scrollController: _emojiScrollController,
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
        //表情区域
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: Colors.white,
            emojiSizeMax: 24,
            columns: 7,
          ),
          //种类区域
          categoryViewConfig: CategoryViewConfig(
            backgroundColor: Colors.white,
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            backspaceColor: Colors.blue,
            tabIndicatorAnimDuration: kTabScrollDuration,
          ),

          skinToneConfig: SkinToneConfig(
            dialogBackgroundColor: Colors.white,
            indicatorColor: Colors.grey,
          ),
          //搜索区域
          searchViewConfig: SearchViewConfig(
            backgroundColor: Colors.white,
            buttonIconColor: Colors.blue,
            hintText: '搜索',
            hintTextStyle: TextStyle(color: Colors.grey),
          ),
          bottomActionBarConfig: BottomActionBarConfig(
            backgroundColor: Colors.white,
            buttonIconColor: Colors.grey,
            buttonColor: Colors.white,
          ),
          viewOrderConfig: ViewOrderConfig(),
          locale: const Locale('zh', 'CN'),
        ),
      ),
    ) : SizedBox.shrink();
  }
}
