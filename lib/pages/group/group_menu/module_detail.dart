import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ModuleDetail extends StatefulWidget {
  const ModuleDetail({super.key});

  @override
  State<ModuleDetail> createState() => _ModuleDetailState();
}

class _ModuleDetailState extends State<ModuleDetail>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isDisplay = false;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isDisplay = _scrollController.offset > 0;
      });
    });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                toolbarHeight: 40,
                forceElevated: innerBoxIsScrolled,
                title: _isDisplay
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
                pinned: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                expandedHeight: 180,
                backgroundColor: Color(0xFFF5F5F5),
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildBackground(),
                  collapseMode: CollapseMode.pin,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  splashBorderRadius: BorderRadius.circular(10),
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '回复'),
                    Tab(text: '置顶'),
                    Tab(text: '热帖'),
                    Tab(text: '精华'),
                  ],
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerHeight: 0,
                  indicatorWeight: 0.5,
                  labelStyle: const TextStyle(fontSize: 15),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                ),
              ),
            ),
          ];
        },
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.offset > 10) {
                  setState(() {
                    _isDisplay = true;
                  });
                } else {
                  setState(() {
                    _isDisplay = false;
                  });
                }
              });
            }
            return true;
          },
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildListView('新回复内容'),
              _buildListView('置顶内容'),
              _buildListView('热帖内容'),
              _buildListView('精华内容'),
            ],
          ),
        ));
  }

  Widget _buildListView(String prefix, {int itemCount = 20}) {
    return Builder(
      builder: (BuildContext context) {
        return Material(
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('$prefix $index'));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackground() {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 10,right: 10),
      color: Colors.orange[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModuleHeader(),
          SizedBox(height: 10,),
          _buildModuleButton(),
        ],
      ),
    );
  }
  Widget _buildModuleButton(){
  return Row(
    children: [
      _buildButton('板块说明',onTap: (){}),
      SizedBox(width: 10),
      _buildButton('版主',onTap: (){}),
      SizedBox(width: 10),
      _buildButton('版规',onTap: (){}),
    ],
  );
 }

  Widget _buildModuleHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildModuleInfo(),
        _buildButton('收藏',onTap: (){}),
      ],
    );
  }

  Widget _buildModuleInfo() {
    return Row(
      children: [
        _buildModuleImage(),
        SizedBox(width: 10),
        _buildModuleText(),
      ],
    );
  }

  Widget _buildModuleImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://picsum.photos/200/300?random=1',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildModuleText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '英雄联盟',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        Text(
          '11.0即将上线',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildButton(String text, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      height: 35,
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
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
    return Material(
      color: Color(0xFFF5F5F5),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
