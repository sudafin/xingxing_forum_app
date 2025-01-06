import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String version = '';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Logo部分
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 16),
                Text(
                  '星行论坛',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('版本 $version'),
              ],
            ),
          ),
          // 功能列表
          ListTile(
            leading: Icon(Icons.description),
            title: Text('用户协议'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 跳转到用户协议页面
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('隐私政策'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 跳转到隐私政策页面
            },
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('检查更新'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 检查更新逻辑
              _checkUpdate(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('意见反馈'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // 跳转到意见反馈页面
            },
          ),
        ],
      ),
    );
  }

  void _checkUpdate(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('检查更新'),
        content: Text('当前已是最新版本'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('确定'),
          ),
        ],
      ),
    );
  }
}