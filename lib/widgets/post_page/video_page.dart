import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:video_compress/video_compress.dart';
import 'package:path_provider/path_provider.dart';

class VideoPage extends StatefulWidget {
  // final Function(String) onVideoSelected;
  final List<Map<String, String>> selectedVideos;

  const VideoPage({super.key, required this.selectedVideos});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final Map<String, String> _thumbnailCache = {};
  List<Map<String, String>> _selectedVideos = [];

  @override
  void initState() {
    super.initState();
    _selectedVideos = widget.selectedVideos;
  }

  Future<String?> _generateThumbnail(String videoPath) async {
    try {
      final thumbnail = await VideoCompress.getFileThumbnail(
        videoPath,
        quality: 100,     // 缩略图质量 0-100
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
