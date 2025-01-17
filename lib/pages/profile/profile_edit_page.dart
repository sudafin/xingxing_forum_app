import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../../enum/edit_type_enum.dart';
import 'profile_edit_detail.dart';
import 'dart:io';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final ImagePicker _picker = ImagePicker();
  bool isImage = false;
  String? imagePath;
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
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath = image.path;
        setState(() {
          isImage = true;
        });
      }
    } catch (e) {
      Log.info('选择图片失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '编辑资料',
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blue[400]!.withOpacity(0.3),
                  radius: 50,
                  child: isImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.file(
                              File(imagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                ),
              ),
              Positioned(
                right: -5,
                bottom: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500]!.withOpacity(0.3),
                  radius: 15,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.name, initialValue: 'momo')));
          },
          title: Text('昵称'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'momo',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.gender, initialValue: '男')));
          },
          title: Text('性别'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '男',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.email,
                        initialValue: 'momo@gmail.com')));
          },
          title: Text('邮箱'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'momo@gmail.com',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.phone, initialValue: '1234567890')));
          },
          title: Text('手机号'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '1234567890',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.birthday,
                        initialValue: '2000-01-01')));
          },
          title: Text('生日'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '2000-01-01',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.address, initialValue: '北京市海淀区')));
          },
          title: Text('地址'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '北京市海淀区',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.job, initialValue: '程序员')));
          },
          title: Text('职业'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '程序员  ',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.school, initialValue: '北京大学')));
          },
          title: Text('学校'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '北京大学',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditDetail(
                        editType: EditType.remark, initialValue: '个人简介')));
          },
          title: Text('简介'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '个人简介',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
