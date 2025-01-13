import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import 'package:xingxing_forum_app/utils/show_toast.dart';
import 'package:provider/provider.dart';
import '../../store/store_viewmodel.dart';
import '../../widgets/post_detail_page.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  RecommendPageState createState() => RecommendPageState();
}

class RecommendPageState extends State<RecommendPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // 自动轮播
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 2), () {
      if (_currentIndex < 3) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startAutoScroll(); // 递归调用
    });
  }
    Future<void> _refreshData() async {
    // 在这里添加你的数据刷新逻辑
    await Future.delayed(Duration(seconds: 0)); // 模拟网络请求
    setState(() {
      // TODO:更新状态
      // 设置弹窗
      ShowToast.showCustomDialog(context, '提示', '刷新成功', '取消', '确认', () {}, () {});
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 设置为最小高度
          children: [
          // 轮播图片组件
          Container(
            margin: EdgeInsets.all(10),
            height: 200, // 设置轮播组件的高度
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: 4, // 设置为4张图片
                  itemBuilder: (context, index) {
                    return _buildCarouselItem(index);
                  },
                ),
                // 指示灯
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Row(
                          children: [
                            Container(
                              width: _currentIndex == index ? 40 : 20, // 当前指示灯宽度更大
                              height: 3,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? (context.watch<StoreViewModel>().theme == Brightness.light 
                                        ? Colors.blue 
                                        : Colors.white)
                                    : (context.watch<StoreViewModel>().theme == Brightness.light 
                                        ? Colors.grey 
                                        : Colors.grey[700]),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(width: 5), // 设置指示灯之间的间距
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8), // 间距
          // 广告位
          Container(
            height: 100, // 设置广告位的高度
            color: context.watch<StoreViewModel>().theme == Brightness.light 
              ? Colors.grey[300]
              : Colors.grey[800],
            child: Center(
              child: Text(
                '广告位', 
                style: TextStyle(
                  fontSize: 20,
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.black
                    : Colors.white,
                )
              ),
            ),
          ),
          SizedBox(height: 8), // 间距
          // 帖子列表
          GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 每行显示两个项目
              crossAxisSpacing: 8, // 水平间距
              mainAxisSpacing: 8, // 垂直间距
              childAspectRatio: 1.0, // 宽高比
            ),
            itemCount: 10, // 假设有10个帖子
            shrinkWrap: true, // 使 GridView 的高度适应内容
            physics: NeverScrollableScrollPhysics(), // 禁止 GridView 滚动
            itemBuilder: (context, index) {
              return _buildPostItem(context, index);
            },
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildCarouselItem(int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/200/300?random=$index'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                      imageCount: 1,
                      category: '1',
                      interactions: {'1': 1},
                      postId: '123',
                    ),
                  ),
                );
      },
      child: Card(
        elevation: 4,
        color: context.watch<StoreViewModel>().theme == Brightness.light 
          ? Colors.white
          : Colors.grey[850],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150, // 设置帖子图片的高度
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/200/300?random=$index'),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    color: context.watch<StoreViewModel>().theme == Brightness.light 
                      ? Colors.black54
                      : Colors.black87,
                    child: Text(
                      '分类 $index',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                '帖子标题测试帖子标题测试帖子标题测试帖子标题测试帖子标题测试帖子标题测试帖子标题测试帖子标题测试帖子标题测试 $index',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: context.watch<StoreViewModel>().theme == Brightness.light 
                    ? Colors.black
                    : Colors.white,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
