import 'package:flutter/material.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // 假设有10个帖子
      itemBuilder: (context, index) {
        return _buildPostItem(context, index);
      },
    );
  }

  Widget _buildPostItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text('帖子标题 $index'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('发帖人: 用户$index'),
            Text('时间: ${DateTime.now().subtract(Duration(days: index)).toLocal()}'),
            Text('回复数量: ${index * 2}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            _showBottomSheet(context);
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('收藏'),
                onTap: () {
                  // 处理收藏逻辑
                  Navigator.pop(context); // 关闭底部弹窗
                },
              ),
              // 可以添加更多选项
            ],
          ),
        );
      },
    );
  }
}
