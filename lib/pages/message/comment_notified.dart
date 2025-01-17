import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../../widgets/post_detail_page.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CommentNotifiedPage extends StatefulWidget {
  const CommentNotifiedPage({super.key});

  @override
  State<CommentNotifiedPage> createState() => _CommentNotifiedPageState();
}

class _CommentNotifiedPageState extends State<CommentNotifiedPage> {
  bool isLiked = false;
  bool isShow = true;
  bool showEmoji = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _emojiScrollController = ScrollController();
  XFile? selectedImage;

  
  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        textEditingController: _textController,
        scrollController: _emojiScrollController,
        onEmojiSelected: (Category? category, Emoji emoji) {
        //这里得用setState,但是会点击输入框才会出现发送按钮,因为这里是底部弹窗得用setModalState才会及时
          setState(() {
            isShow = false;
          });  
        },
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
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = image;
        });
      }
    } catch (e) {
    Log.info('Error picking image: $e');
    }
  }

  Widget _buildImagePreview() {
    if (selectedImage == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(selectedImage!.path),
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: -12,
            top: -12,
            child: IconButton(
              icon: const Icon(
                Icons.cancel,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  selectedImage = null;
                });
                if (context.mounted) {
                  Navigator.of(context).pop();
                  _showCommentInput(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentInput(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Color(0xFFFAFAFA),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 5,
                    right: 10,
                    top: 5
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 50,
                                maxHeight: 120,
                              ),
                              child: TextField(
                                focusNode: focusNode,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                onTap: () {
                                  setState(() {
                                    showEmoji = false;
                                    focusNode.requestFocus();
                                  });
                                },
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                maxLines: isShow ? 1 : 5,
                                minLines: 1,
                                controller: _textController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: '发送消息',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[400]
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  setModalState(() {
                                    isShow = value.isEmpty;
                                  });
                                },
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                            //setModalState适用于在showModalBottomSheet中使用
                              setModalState(() {
                                showEmoji = !showEmoji;
                                if (showEmoji) {
                                  FocusScope.of(context).unfocus();
                                }
                              });
                            },
                            icon: Icon(
                              showEmoji 
                                ? Icons.keyboard_alt_outlined
                                : Icons.emoji_emotions_outlined
                            )
                          ),
                          isShow
                              ? IconButton(
                                  onPressed: () async {
                                    await _pickImage();
                                    setModalState(() {});
                                  },
                                  icon: Icon(Icons.attach_file_outlined)
                                )
                              : TextButton(
                                  onPressed: () {},
                                  child: Text('发送')
                                )
                        ],
                      ),
                      if (selectedImage != null) _buildImagePreview(),
                    ],
                  ),
                ),
                if (showEmoji) _buildEmojiPicker(),
              ],
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '收到的评论和@',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 50,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // 这里添加刷新逻辑
          // 例如：重新获取数据
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
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '回复了你的帖子/评论',
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
                      SizedBox(height: 5),
                      //评论内容
                      Text(
                        '评论内容顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        softWrap: true,
                        //用省略号代替裁剪的文本
                        overflow: TextOverflow.ellipsis,
                        //最多显示10行
                        maxLines: 10,
                      ),
                      //被回复的评论
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
                SizedBox(height: 10),
                //点赞和评论按钮
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[400]!.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              },
                              child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16,
                                color: isLiked ? Colors.red : Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '赞',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        )),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        focusNode.requestFocus();
                        _showCommentInput(context);
                      },
                      child: Container(
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[400]!.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 16,
                              color: Colors.black,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '回复',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          //帖子封面
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
