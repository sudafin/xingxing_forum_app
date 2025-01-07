import 'package:flutter/material.dart';
import '../../widgets/post_detail_page.dart';
import '../../widgets/image_preview_page.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  final List<String> categories = ['游戏', '动漫', '科技'];
  final List<Map<String, int>> interactions = [
    {'likes': 1234, 'comments': 66, 'shares': 28},
    {'likes': 888, 'comments': 32, 'shares': 15},
    {'likes': 2345, 'comments': 128, 'shares': 45},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildPostCard(3), // 三张图的帖子
        _buildPostCard(2), // 两张图的帖子  
        _buildPostCard(1), // 一张图的帖子
      ],
    );
  }

  Widget _buildPostCard(int imageCount) {
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
                    'https://picsum.photos/200/300?random=${imageCount * 10}',
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '用户名',
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
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    categories[imageCount - 1],
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
                      category: categories[imageCount - 1],
                      interactions: interactions[imageCount - 1],
                      postId: '123',
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '这是一段示例文本内容,用来测试帖子的显示效果。这里可以显示用户发布的具体内容。',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  _buildImageGrid(imageCount),
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
                      interactions[imageCount - 1]['likes']!,
                    ),
                    const SizedBox(width: 16),
                    _buildInteractionButton(
                      Icons.comment_outlined,
                      interactions[imageCount - 1]['comments']!,
                    ),
                  ],
                ),
                _buildInteractionButton(
                  Icons.share_outlined,
                  interactions[imageCount - 1]['shares']!,
                  showBorder: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(int imageCount) {
    double containerWidth = MediaQuery.of(context).size.width - 40;
    double containerHeight = 200.0;

    if (imageCount == 1) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePreviewPage(
                imageUrl: 'https://picsum.photos/200/300?random=1',
                heroTag: 'popular_1',
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
              image: NetworkImage('https://picsum.photos/200/300?random=1'),
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
                        imageUrl: 'https://picsum.photos/200/300?random=${index + 2}',
                        heroTag: 'popular_2',
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
                        'https://picsum.photos/200/300?random=${index + 2}',
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
                        imageUrl: 'https://picsum.photos/200/300?random=${index + 5}',
                        heroTag: 'popular_3',
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
                        'https://picsum.photos/200/300?random=${index + 5}',
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

