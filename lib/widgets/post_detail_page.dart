import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'image_preview_page.dart';
import 'package:provider/provider.dart';
import '../store/store_viewmodel.dart';

class PostDetailPage extends StatefulWidget {
  final int? imageCount;
  final String? category;
  final Map<String, int>? interactions;
  final String postId;

  const PostDetailPage({
    super.key,
    this.imageCount,
    this.category,
    this.interactions,
    required this.postId,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _commentController = TextEditingController();
  bool _isLiked = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子详情'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // 显示更多操作菜单
              Fluttertoast.showToast(msg: '更多操作');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 帖子内容区域
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo(),
                      _buildPostContent(),
                      _buildImageGrid(),
                      _buildInteractionBar(),
                      SizedBox(height: 10),
                      Divider(height: 3, color: Colors.grey[300]),
                      _buildCommentAppBar(),
                    ],
                  ),
                ),
                // 评论列表
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildCommentItem(index),
                    childCount: 50, // 示例评论数量
                  ),
                ),
              ],
            ),
          ),
          // 底部评论输入框
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://picsum.photos/200/300?random=${widget.imageCount! * 10}',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '用户名',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '2小时前',
                  style: TextStyle(
                    color: context.watch<StoreViewModel>().theme == Brightness.light 
                      ? Colors.grey[600] 
                      : Colors.grey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: context.watch<StoreViewModel>().theme == Brightness.light 
                ? Colors.blue.withAlpha(10)
                : Colors.blue.withAlpha(30),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.watch<StoreViewModel>().theme == Brightness.light 
                  ? Colors.blue.withAlpha(10)
                  : Colors.blue.withAlpha(30),
              ),
            ),
            child: Text(
              '关注',
              style: TextStyle(
                color: context.watch<StoreViewModel>().theme == Brightness.light 
                  ? Colors.blue
                  : Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 帖子内容
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '这是一段详细的帖子内容。可以显示更多的文字，而不需要省略。这里可以讲述更多的故事和细节。这是一段示例文本，用来测试长文本的显示效果。',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    int? count,
    bool isLiked = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isLiked ? Colors.red : Colors.grey[600],
            ),
            if (count != null) ...[
              const SizedBox(width: 4),
              Text(
                _formatNumber(count),
                style: TextStyle(
                  color: isLiked ? Colors.red : Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    double containerWidth = MediaQuery.of(context).size.width - 32;
    double aspectRatio = 1.0;
    int crossAxisCount = 3;
    double spacing = 4.0;

    double itemWidth = (containerWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;
    double itemHeight = itemWidth / aspectRatio;

    int rowCount = (widget.imageCount! > 3) ? 2 : 1;
    double containerHeight = (rowCount * itemHeight) + ((rowCount - 1) * spacing);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: const EdgeInsets.all(2),
        width: containerWidth,
        height: containerHeight,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemCount: widget.imageCount! > 6 ? 6 : widget.imageCount!,
          itemBuilder: (context, index) {
            String imageUrl = 'https://picsum.photos/200/300?random=${index + 1}';
            String heroTag = 'post_image_${widget.imageCount}_$index';
            
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewPage(
                      imageUrl: imageUrl,
                      heroTag: heroTag,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: heroTag,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInteractionBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
       children: [
        _buildInteractionButton()
       ],
      )
    );
  }

  Widget _buildInteractionButton() {
    return Row(
        children: [
          Text(
            '2024-03-21 14:30',
            style: TextStyle(
              color: context.watch<StoreViewModel>().theme == Brightness.light 
                ? Colors.grey[600]
                : Colors.grey[300],
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              _buildActionButton(
                icon: Icons.thumb_up,
                count: widget.interactions?['likes'],
                isLiked: _isLiked,
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
              ),
              const SizedBox(width: 24),
              _buildActionButton(
                icon: Icons.thumb_down,
                onTap: () {
                  Fluttertoast.showToast(msg: '踩一下');
                },
              ),
              const SizedBox(width: 24),
              _buildActionButton(
                icon: Icons.share,
                onTap: () {
                  Fluttertoast.showToast(msg: '分享');
                },
              ),
            ],
          ),
        ],
      );
  }

  bool _isSortedAscending = true;
  Widget _buildCommentAppBar() {
    return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 10,),
        Text(
          '全部评论${widget.interactions?['comments']}',
          style: TextStyle(
            fontSize: 14,
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? Colors.black
              : Colors.white,
          ),
        ),
        const Spacer(),
        Container(
        padding: EdgeInsets.all(1),
          child: Row(
            children: [
              Text(
                _isSortedAscending ? '正序' : '倒序',
                style: TextStyle(
                  fontSize: 14,
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.black
                    : Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.sort,
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.black
                    : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isSortedAscending = !_isSortedAscending;
                  });
                },
              ),
            ]
          ),
        ),
        
        
      ],
    );
  }

  Widget _buildCommentItem(int index) {
    bool hasReplies = index % 3 == 0; // 示例：每三个评论显示一个带回复的评论

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://picsum.photos/200/300?random=${100 + index}',
            ),
          ),
          title: Row(
            children: [
              const Text(
                '评论用户',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '${index + 1}小时前',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '这是第 ${index + 1} 条评论，用来测试评论的显示效果。',
                  style: TextStyle(
                    color: context.watch<StoreViewModel>().theme == Brightness.light 
                      ? Colors.black
                      : Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 14,
                    color: context.watch<StoreViewModel>().theme == Brightness.light 
                      ? Colors.grey[500]
                      : Colors.grey[300],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${12 + index}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.reply, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    '回复',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (hasReplies) _buildReplySection(),
      ],
    );
  }

  Widget _buildReplySection() {
    return Container(
      margin: const EdgeInsets.only(left: 56, right: 16, bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.watch<StoreViewModel>().theme == Brightness.light 
          ? Colors.grey[100]
          : Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildReplyItem('回复用户1', '这是一条回复评论'),
          const SizedBox(height: 8),
          _buildReplyItem('回复用户2', '这是另一条回复评论'),
          TextButton(
            onPressed: () {
              // 查看更多回复
              Fluttertoast.showToast(msg: '查看更多回复');
            },
            child: Text(
              '查看更多回复 >',
              style: TextStyle(
                color: context.watch<StoreViewModel>().theme == Brightness.light 
                  ? Colors.grey[600]
                  : Colors.grey[300],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyItem(String username, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
        const Text(
          '：',
          style: TextStyle(fontSize: 14),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 8,
      ),
      decoration: BoxDecoration(
        color: context.watch<StoreViewModel>().theme == Brightness.light 
          ? Colors.white
          : Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: '发表评论...',
                hintStyle: TextStyle(
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.grey[400]
                    : Colors.grey[600],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: context.watch<StoreViewModel>().theme == Brightness.light 
                  ? Colors.grey[100]
                  : Colors.grey[800],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              style: TextStyle(
                color: context.watch<StoreViewModel>().theme == Brightness.light 
                  ? Colors.black
                  : Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_commentController.text.trim().isNotEmpty) {
                  Fluttertoast.showToast(msg: '发送评论：${_commentController.text}');
                  _commentController.clear();
                }
              },
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