import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ModuleDetail extends StatefulWidget {
  const ModuleDetail({super.key});

  @override
  State<ModuleDetail> createState() => _ModuleDetailState();
}

class _ModuleDetailState extends State<ModuleDetail> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isTransparent = true;
  double _opacity = 1.0;
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(_opacity),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: !_isTransparent
            ? TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 50, end: 0),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, value),
                    child: Text('游戏'),
                  );
                },
              )
            : null,
        toolbarHeight: 40,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            // 因为我们需要使用回调函数,并且在函数中使用setSate,那么如果页面渲染过快可能导致setSate失败,所以需要使用 SchedulerBinding 在帧结束后更新状态,也就是渲染结束后setState修改状态
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final newOpacity = 1 - _scrollController.offset / 100;
              if (newOpacity != _opacity) {
                print('newOpacity: $newOpacity');
                setState(() {
                  _opacity = newOpacity.clamp(0.0, 1.0);
                });
              }
              final newTransparent = _scrollController.offset < 100;
              if (newTransparent != _isTransparent) {
                setState(() {
                  _isTransparent = newTransparent;
                });
              }
            });
          }
          return true;
        },
        child: ModulePageBody(
          scrollController: _scrollController,
        ),
      ),
    );
  }
}

class ModulePageBody extends StatefulWidget {
  final ScrollController scrollController;
  const ModulePageBody({
    super.key,
    required this.scrollController,
  });
  @override
  State<ModulePageBody> createState() => _ModulePageBodyState();
}

class _ModulePageBodyState extends State<ModulePageBody>
    with TickerProviderStateMixin {
  
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    
    _tabController = TabController(length: 4, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: widget.scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: false,
            forceElevated: innerBoxIsScrolled,
            expandedHeight: 120,
            backgroundColor: Colors.blueGrey,
            //把这里的appbar的leading去掉
            leading: SizedBox.shrink(),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    color: Colors.blueGrey,
                  ),
                  collapseMode: CollapseMode.pin,
                );
              },
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: '新贴'),
                  Tab(text: '置顶'),
                  Tab(text: '热帖'),
                  Tab(text: '精华'),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                dividerHeight: 0,
                indicatorWeight: 0.5,
                labelStyle: TextStyle(fontSize: 15),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              ),
            ),
          ),
        ];
      },
      //设置body
      body: TabBarView(
        controller: _tabController,
        children: [
          // 新回复标签页
          ListView.builder(
            itemCount: 10,  // 替换为实际的数据长度
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('新回复内容 $index'),
              );
            },
          ),
          // 置顶标签页
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('置顶内容 $index'),
              );
            },
          ),
          // 热帖标签页
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('热帖内容 $index'),
              );
            },
          ),
          // 精华标签页
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('精华内容 $index'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
      //设置tabbar的背景颜色.需要使用Material包裹
    return Material(
      color:  Color(0xFFF5F5F5),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
