import 'package:flutter/material.dart';
import '../../../widgets/post_detail_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> categories = ['游戏', '动漫', '科技', '美食', '旅游'];
  final List<Map<String, int>> interactions = [
    {'likes': 1234, 'comments': 66, 'shares': 28},
    {'likes': 888, 'comments': 32, 'shares': 15},
    {'likes': 2345, 'comments': 128, 'shares': 45},
    {'likes': 666, 'comments': 45, 'shares': 12},
    {'likes': 999, 'comments': 88, 'shares': 33},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('浏览历史'),
        centerTitle: true,
        //清空按钮
        actions: [
          TextButton(
            onPressed: () {
              // 清空按钮的逻辑
            },
            child: const Text('清空', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // 显示更多的历史记录
        itemBuilder: (context, index) {
          return _buildHistoryCard(index);
        },
      ),
    );
  }

  Widget _buildHistoryCard(int index) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white,
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 用户信息行
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/200/300?random=${index * 10}',
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '历史记录',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '2小时前浏览',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    categories[index % categories.length],
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 内容区域
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                      imageCount: 0, // 不显示图片
                      category: categories[index % categories.length],
                      interactions: interactions[index % interactions.length],
                      postId: 'history_$index',
                    ),
                  ),
                );
              },
              child: Text(
                '这是浏览历史记录 $index，用来测试历史记录的显示效果。这里可以显示用户浏览过的帖子内容。这是一段比较长的文本，用来测试多行文本的显示效果。',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            // 底部操作栏
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildInteractionButton(
                      Icons.thumb_up_outlined,
                      interactions[index % interactions.length]['likes']!,
                    ),
                    const SizedBox(width: 16),
                    _buildInteractionButton(
                      Icons.comment_outlined,
                      interactions[index % interactions.length]['comments']!,
                    ),
                  ],
                ),
                _buildInteractionButton(
                  Icons.share_outlined,
                  interactions[index % interactions.length]['shares']!,
                  showBorder: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton(
    IconData icon,
    int count, {
    bool showBorder = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: showBorder
          ? BoxDecoration(
              border: Border.all(color: Colors.grey.withAlpha(10)),
              borderRadius: BorderRadius.circular(20),
            )
          : null,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            _formatNumber(count),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 10000) {
      return '${(number / 10000).toStringAsFixed(1)}w';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
