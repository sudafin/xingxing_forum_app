import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../store/store_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<StoreViewModel>().theme == Brightness.light 
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF303030),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? Colors.black
              : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '设置',
          style: TextStyle(
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? Colors.black
              : Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSettingGroup(context, [
            _buildSettingItem(context, '账号管理', onTap: () {}),
            _buildSettingItem(context, '账号安全', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '深色模式', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '显示与网络设置', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '清除缓存', trailing: '46.96 MB', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '网络诊断', onTap: () {}),
            _buildSettingItem(context, 'DNS诊断检测', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '消息与推送', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '隐私管理', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '反馈与建议', onTap: () {}),
          ]),
          _buildSettingGroup(context, [
            _buildSettingItem(context, '桌面小部件', onTap: () {}),
          ]),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // 退出登录逻辑
              },
              child: Text(
                '退出当前账号',
                style: TextStyle(
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.orange
                    : Colors.orange[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingGroup(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.watch<StoreViewModel>().theme == Brightness.light 
          ? Colors.white
          : const Color(0xFF424242),
        border: Border(
          top: BorderSide(
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? const Color(0xFFE5E5E5)
              : Colors.grey[700]!,
          ),
          bottom: BorderSide(
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? const Color(0xFFE5E5E5)
              : Colors.grey[700]!,
          ),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title, {
    String? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.watch<StoreViewModel>().theme == Brightness.light 
                ? const Color(0xFFE5E5E5)
                : Colors.grey[700]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.black
                    : Colors.white,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing,
                style: TextStyle(
                  fontSize: 14,
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.grey[600]
                    : Colors.grey[400],
                ),
              ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: context.watch<StoreViewModel>().theme == Brightness.light 
                ? Colors.grey[400]
                : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}