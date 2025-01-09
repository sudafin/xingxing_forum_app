import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../store/store_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final List<String> selectedImages = [];
  final List<String> selectedVideos = [];
  bool isShow = false;
  bool isAdd = false;
  bool isEmoji = false;
  bool isAlbum = false;
  bool isVideo = false;

  void _insertEmoji(String emoji) {
    //获取当前内容框中的的全部文本
    final text = _contentController.text;
    //获取当前光标所在位置,也就是我们要插入的位置,其中selection.start是开始位置,selection.end是结束位置
    final selection = _contentController.selection;
    Log.info(
        "selection: ${selection.start} ${selection.end} ${selection.baseOffset}}");
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

  // void _insertImage(String imagePath) {
  //   //内容框为编辑状态
  //   final text = _contentController.text;
  //   final selection = _contentController.selection;
  //   final imageTag = '[图片:$imagePath]';
  //   final newText = text.replaceRange(selection.start, selection.end, imageTag);
  //   _contentController.value = TextEditingValue(
  //     text: newText,
  //     selection: TextSelection.collapsed(
  //       offset: selection.baseOffset + imageTag.length,
  //     ),
  //   );

  //   // 可以在这里添加图片上传逻辑
  // }

  // void _insertVideo(String videoPath) {
  //   final text = _contentController.text;
  //   final selection = _contentController.selection;
  //   final videoTag = '[视频:$videoPath]';
  //   final newText = text.replaceRange(selection.start, selection.end, videoTag);
  //   _contentController.value = TextEditingValue(
  //     text: newText,
  //     selection: TextSelection.collapsed(
  //       offset: selection.baseOffset + videoTag.length,
  //     ),
  //   );
  // }


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
                            if (isAdd) const AddPage(),
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

class EmojiPage extends StatelessWidget {
  final Function(String) onEmojiSelected;

  const EmojiPage({super.key, required this.onEmojiSelected});

  @override
  Widget build(BuildContext context) {
    final List<String> emojis = [
      '😀',
      '😂',
      '🤣',
      '😊',
      '😍',
      '🥰',
      '😘',
      '😋',
      '🤔',
      '😑',
      '😶',
      '😏',
      '😒',
      '🙄',
      '😳',
      '😱',
      '😭',
      '😩',
      '🥺',
      '😡'
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: emojis.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onEmojiSelected(emojis[index]),
            child: Center(
              child: Text(
                emojis[index],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AlbumPage extends StatefulWidget {
  final List<String> selectedImages;
  const AlbumPage({super.key, required this.selectedImages});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<String> _selectedImages = [];
  @override
  void initState() {
    super.initState();
    _selectedImages = widget.selectedImages;
  }


  Future<void> _pickImage() async {
    // 首先请求权限
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
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920, // 限制图片大小
        maxHeight: 1080,
        imageQuality: 85, // 压缩质量
      );

      if (image != null) {
        setState(() {
          // 将选择的图片路径添加到已选择图片列表中
          _selectedImages.add(image.path);
        });
        // 将选择的图片路径传递给父组件
        // widget.onImageSelected(image.path);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('选择图片失败，请重试')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            height: SizeFit.screenHeight * 0.3,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _selectedImages.length + 1, // 增加一个格子用于显示选择图片按钮
              itemBuilder: (context, index) {
                if (index == _selectedImages.length) {
                  // 最后一个格子显示选择图片按钮
                  return GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else {
                  // 其他格子显示已选择的图片
                  return Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: FileImage(File(_selectedImages[index])),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



class VideoPage extends StatefulWidget {
  // final Function(String) onVideoSelected;
  final List<String> selectedVideos;

  const VideoPage({super.key, required this.selectedVideos});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final Map<String, String> _thumbnailCache = {};
  final List<Map<String, String>> _selectedVideos = [];

  @override
  void initState() {
    super.initState();
    _initThumbnails();
  }

  Future<String?> _generateThumbnail(String videoPath) async {
    try {
      final thumbnail = await VideoCompress.getFileThumbnail(
        videoPath,
        quality: 50,     // 缩略图质量 0-100
        position: -1,    // -1 表示自动选择视频帧位置
      );
      
      return thumbnail.path;
    } catch (e) {
      debugPrint('生成缩略图失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('生成视频预览失败')),
        );
      }
      return null;
    }
  }

  Future<void> _initThumbnails() async {
    for (var video in widget.selectedVideos) {
      final thumbnail = await _generateThumbnail(video);
      if (thumbnail != null) {
        setState(() {
          _selectedVideos.add({
            'video': video,
            'thumbnail': thumbnail,
          });
        });
      }
    }
  }

  Future<void> _pickVideo() async {
  //请求权限
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('需要存储权限才能选择视频')),
          );
        }
        return;
      }
    }

  // 检查视频数量限制
    if (_selectedVideos.length >= 9) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('最多只能选择9个视频')),
        );
      }
      return;
    }
  
    // 选择视频
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(
        source: ImageSource.gallery,
        // 限制视频时长
        maxDuration: const Duration(seconds: 10),
      );
      // 选择视频成功
      if (video != null) {
        // 生成缩略图
        final thumbnailPath = await _generateThumbnail(video.path);
        // 缩略图生成成功
        if (thumbnailPath != null) {
          setState(() {
            // 将视频路径和缩略图路径添加到已选择视频列表中
            _selectedVideos.add({
              'video': video.path,
              'thumbnail': thumbnailPath,
            });
          });
          // 将视频路径传递给父组件
          // widget.onVideoSelected(video.path);
          
        }
      }
    } catch (e) {
      debugPrint('选择视频失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('选择视频失败，请重试')),
        );
      }
    }
  }

  @override 
  void dispose() {
    // 清理临时缩略图文件
    _clearUnusedThumbnails();
    super.dispose();
  }

  Future<void> _clearUnusedThumbnails() async {
    try {

      final tempDir = await getTemporaryDirectory();
      // 获取临时目录
      final thumbnailDir = Directory(tempDir.path);
      // 获取临时目录下的所有文件
      final files = await thumbnailDir.list().where((entity) => 
        entity is File && entity.path.contains('thumbnail_')
      ).toList();
      
      for (var file in files) {
        if (file is File && !_thumbnailCache.values.contains(file.path)) {
          await file.delete();
        }
      }
    } catch (e) {
      debugPrint('清理缩略图失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _pickVideo,
                child: const Text('选择视频',style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          if (_selectedVideos.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),  
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _selectedVideos.length,
              itemBuilder: (context, index) {
                final thumbnailPath = _selectedVideos[index]['thumbnail'];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.topRight,
                    children: [
                      if (thumbnailPath == null)
                        const Center(child: CircularProgressIndicator())
                      else
                        Image.file(
                          File(thumbnailPath),  // 现在确保 thumbnailPath 不为 null
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedVideos.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
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
