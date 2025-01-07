import 'package:flutter/material.dart';
import '../../widgets/post_detail_page.dart';
import '../../widgets/image_preview_page.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});
  @override
  FollowPageState createState() => FollowPageState();
}

class FollowPageState extends State<FollowPage> {
  final List<String> categories = ['游戏', '动漫', '科技', '美食', '旅游'];
  final List<Map<String, int>> interactions = [
    {'likes': 234, 'comments': 16, 'shares': 8},
    {'likes': 568, 'comments': 42, 'shares': 25},
    {'likes': 1345, 'comments': 98, 'shares': 35},
    {'likes': 789, 'comments': 56, 'shares': 18},
    {'likes': 432, 'comments': 28, 'shares': 12},
  ];

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1)); // 模拟网络请求
    setState(() {
      // 重新加载页面
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: 5, // 显示5个帖子
        itemBuilder: (context, index) {
          // 随机生成1-3张图片
          int imageCount = (index % 3) + 1;
          return _buildPostCard(imageCount, index);
        },
      ),
    );
  }

  Widget _buildPostCard(int imageCount, int index) {
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
                        '关注用户',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '2小时前',
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
                    color: Colors.blue.withAlpha(10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    categories[index],
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
                      imageCount: imageCount,
                      category: categories[index],
                      interactions: interactions[index],
                      postId: 'follow_$index',
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '这是关注用户 $index 发布的内容，用来测试帖子的显示效果。这里可以显示用户发布的具体内容。',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  _buildImageGrid(imageCount, index),
                ],
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
                      interactions[index]['likes']!,
                    ),
                    const SizedBox(width: 16),
                    _buildInteractionButton(
                      Icons.comment_outlined,
                      interactions[index]['comments']!,
                    ),
                  ],
                ),
                _buildInteractionButton(
                  Icons.share_outlined,
                  interactions[index]['shares']!,
                  showBorder: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(int imageCount, int postIndex) {
    double containerWidth = MediaQuery.of(context).size.width - 40;
    double containerHeight = 200.0;

    if (imageCount == 1) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePreviewPage(
                imageUrl: 'https://picsum.photos/200/300?random=${postIndex * 3 + 1}',
                heroTag: 'follow_$postIndex',
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(1),
          width: containerWidth * 0.6,
          height: containerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage('https://picsum.photos/200/300?random=${postIndex * 3 + 1}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (imageCount == 2) {
      return Container(
        padding: EdgeInsets.all(1),
        width: containerWidth * 0.8,
        height: containerHeight,
        child: Row(
          children: List.generate(2, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePreviewPage(
                        imageUrl: 'https://picsum.photos/200/300?random=${postIndex * 3 + index + 2}',
                        heroTag: 'follow_$postIndex',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: index == 0 ? 4 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/200/300?random=${postIndex * 3 + index + 2}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(1),
        width: containerWidth,
        height: containerHeight,
        child: Row(
          children: List.generate(3, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagePreviewPage(
                        imageUrl: 'https://picsum.photos/200/300?random=${postIndex * 3 + index + 5}',
                        heroTag: 'follow_$postIndex',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: index < 2 ? 4 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://picsum.photos/200/300?random=${postIndex * 3 + index + 5}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }
  }

  Widget _buildInteractionButton(
    IconData icon,
    int count, {
    bool showBorder = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: showBorder ? BoxDecoration(
        border: Border.all(color: Colors.grey.withAlpha(10)),
        borderRadius: BorderRadius.circular(20),
      ) : null,
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
