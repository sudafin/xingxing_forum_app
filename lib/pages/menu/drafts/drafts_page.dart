import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/store/store_viewmodel.dart';

class DraftsPage extends StatefulWidget {
  const DraftsPage({super.key});

  @override
  State<DraftsPage> createState() => _DraftsPageState();
}

class _DraftsPageState extends State<DraftsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // 模拟主题草稿数据
  final List<Map<String, dynamic>> themeDrafts = [
    {
      'title': '这是一个草稿标题',
      'content': '这是草稿的内容，可能包含一些文字描述...',
      'time': '2024-03-15 10:30',
    },
    {
      'title': '未完成的想法',
      'content': '记录一下突然想到的点子，后面再完善...',
      'time': '2024-03-14 15:20',
    },
    {
      'title': '待发布的文章',
      'content': '这是一篇正在编写的文章，需要进一步修改和完善...',
      'time': '2024-03-13 20:45',
    }
  ];

  // 模拟回复草稿数据
  final List<Map<String, dynamic>> replyDrafts = [
    {
      'title': '回复草稿1',
      'content': '这是一个回复的草稿内容...',
      'time': '2024-03-15 11:30',
    },
    {
      'title': '回复草稿2',
      'content': '另一个回复草稿的内容...',
      'time': '2024-03-14 16:20',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          '草稿箱',
          style: TextStyle(
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? Colors.black
              : Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // 清空按钮的逻辑
            },
            child: Text(
              '清空', 
              style: TextStyle(
                fontSize: 16,
                color: context.watch<StoreViewModel>().theme == Brightness.light 
                  ? Colors.black
                  : Colors.white,
              ),
            ),
          ),
        ],
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          tabs: const [
            Tab(text: '主题'),
            Tab(text: '回复'),
          ],
          labelColor: context.watch<StoreViewModel>().theme == Brightness.light 
            ? Colors.black
            : Colors.white,
          unselectedLabelColor: context.watch<StoreViewModel>().theme == Brightness.light 
            ? Colors.grey
            : Colors.grey[400],
          indicatorColor: context.watch<StoreViewModel>().theme == Brightness.light 
            ? Colors.black
            : Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      body: Column(
        children: [
          // Tab页面
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDraftsList(themeDrafts),
                _buildDraftsList(replyDrafts),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraftsList(List<Map<String, dynamic>> drafts) {
    return drafts.isEmpty
        ? _buildEmptyState()
        : ListView.separated(
            itemCount: drafts.length,
            separatorBuilder: (context, index) => Divider(
              height: 1, 
              color: context.watch<StoreViewModel>().theme == Brightness.light 
                ? const Color(0xFFE5E5E5) 
                : Colors.grey[700],
            ),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                title: Text(
                  drafts[index]['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: context.watch<StoreViewModel>().theme == Brightness.light 
                      ? Colors.black
                      : Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      drafts[index]['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.watch<StoreViewModel>().theme == Brightness.light 
                          ? Colors.grey[600]
                          : Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drafts[index]['time'],
                      style: TextStyle(
                        fontSize: 12,
                        color: context.watch<StoreViewModel>().theme == Brightness.light 
                          ? Colors.grey[400]
                          : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // 点击草稿的处理逻辑
                },
              );
            },
          );
  }

//如果为空设置一张图片
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_drafts.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无内容~',
            style: TextStyle(
              color: context.watch<StoreViewModel>().theme == Brightness.light 
                ? Colors.grey
                : Colors.grey[300],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}