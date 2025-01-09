import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import 'dart:io';

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
