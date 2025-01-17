import 'dart:io';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatScreen extends StatefulWidget {
  final int id;
  const ChatScreen({super.key, required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool isEmoji = false;
  bool isAdd = false;
  bool isShow = true;
  //listview的滚动控制器,用来拉动到最新消息
  final ScrollController _scrollController = ScrollController();
  final ScrollController _emojiScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool showEmoji = false;
  final ImagePicker _picker = ImagePicker();
  bool showAddPanel = false;
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _handleSubmitted(String text, {bool isMedia = false}) {
    _textController.clear();
    setState(() {
      _messages.insert(_messages.length,
          ChatMessage(
            text: text,
            isMe: true,
            time: DateTime.now().toLocal(),
            isMedia: isMedia,
          ));
    });
    // 添加滚动到最新消息
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.insert(
            _messages.length, ChatMessage(text: '这是一条固定的回复消息', isMe: false));
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

  Widget _buildEmojiPicker() {
    return Container(
      height: 250,
      child: EmojiPicker(
        textEditingController: _textController,
        scrollController: _emojiScrollController,
        onEmojiSelected: (Category? category, Emoji emoji) {
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
  var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // 用户拒绝了权限
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('需要存储权限才能选择图片')),
          );
        }
        return;
      }
    }
    // 请求权限成功后,开始选择图片
    try {
      
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920, // 限制图片大小
        maxHeight: 1080,
        imageQuality: 85, // 压缩质量
      );
    if (image != null) {
      _handleSubmitted(image.path, isMedia: true);
    }
    } catch (e) {
      print('选择图片失败: $e');
    }
  }

  Future<void> _pickVideo() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // 用户拒绝了权限
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('需要存储权限才能选择视频')),
          );
        }
        return;
      }
    }
    // 请求权限成功后,开始选择视频
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        _handleSubmitted(video.path, isMedia: true);
      }
    } catch (e) {
      print('选择视频失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        leadingWidth: 200,
        leading: SizedBox(
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
                  
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
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
            onPressed: () {
              Navigator.pushNamed(context, '/chat_setting');
            },
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
            padding: EdgeInsets.all(5),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                   cursorHeight: 15,
                    focusNode: _focusNode,
                    onChanged: (text) {
                      setState(() {
                        isShow = !text.isNotEmpty;
                      });
                    },
                    onTap: () {
                        setState(() {
                          showEmoji = false;
                        });
                        _focusNode.requestFocus();
                    },
                    onTapOutside: (event) {
                      setState(() {
                        showEmoji = false;
                      });
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines:null,
                    minLines: 1,
                    controller: _textController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      hintText: '发送消息',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      isDense: true,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showEmoji = !showEmoji;
                          showAddPanel = false;
                        });
                      },
                      icon: Icon(
                        showEmoji ? Icons.keyboard : Icons.emoji_emotions_outlined,
                        size: 30,
                        color: Colors.grey[500],
                      ),
                    ),
                    isShow
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                showAddPanel = !showAddPanel;
                                showEmoji = false;
                              });
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 30,
                              color: Colors.grey[500],
                            ))
                        : TextButton(
                            onPressed: () {
                              _handleSubmitted(_textController.text);
                              _textController.clear();
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
                ),
              ],
            ),
            if (showEmoji) _buildEmojiPicker(),
            if (showAddPanel) _buildAddPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPanel() {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.image, size: 40,color: Colors.blue),
            onPressed: () {
              setState(() {
                showAddPanel = false;
              });
              _pickImage();
            },
          ),
          IconButton(
            icon: Icon(Icons.video_library, size: 40,color: Colors.blue),
            onPressed: () {
              setState(() {
                showAddPanel = false;
              });
              _pickVideo();
            },
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime? time;
  final bool isMedia;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isMe,
    this.time,
    this.isMedia = false,
  });

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
                      child: isMedia
                          ? text.endsWith('.mp4') || text.endsWith('.mov')
                              ? FutureBuilder<File?>(
                                  future: VideoCompress.getFileThumbnail(
                                    text,
                                    quality: 50,
                                    position: -1,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    if (snapshot.hasData) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.file(snapshot.data!, 
                                            width: 200, 
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            bottom: 8,
                                            right: 8,
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: FutureBuilder<MediaInfo?>(
                                                future: VideoCompress.getMediaInfo(text),
                                                builder: (context, infoSnapshot) {
                                                  if (infoSnapshot.hasData) {
                                                    final duration = Duration(seconds: infoSnapshot.data!.duration?.toInt() ?? 0);
                                                    return Text(
                                                      '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                                      style: TextStyle(color: Colors.white),
                                                    );
                                                  }
                                                  return SizedBox.shrink();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return Text('无法加载视频缩略图');
                                  },
                                )
                              : Image.file(File(text), width: 200, height: 200)
                          : Text(text,
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
