import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';
import '../../store/store_viewmodel.dart';
import 'package:provider/provider.dart';
import 'profile_build_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    // 获取当前路由名称
    final routeName = ModalRoute.of(context)?.settings.name;
    // 如果是push过来的获取传递的参数
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Colors.blueGrey.withOpacity(_opacity),
              scrolledUnderElevation: 0,
              iconTheme: IconThemeData(
                color: _isTransparent 
                    ? (context.watch<StoreViewModel>().theme == Brightness.light
                        ? Colors.white
                        : Colors.black)
                    : (context.watch<StoreViewModel>().theme == Brightness.light
                        ? Colors.blue
                        : Colors.white),
              ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: !_isTransparent
              ? TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 50, end: 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: Image.asset('assets/images/logo.png',
                          width: 100, height: 100),
                    );
                  },
                )
              : null,
          toolbarHeight: 60,
        ),
        drawer: routeName != '/profile'  ? MenuDrawer() : null,
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
          print('_scrollController.offset:${_scrollController.offset}');
          //设置透明度
            final newOpacity = 1 - _scrollController.offset / 210;
            if (newOpacity != _opacity) {
              setState(() {
                _opacity = newOpacity.clamp(0.0, 1.0);
              });
            }
            if (notification is ScrollUpdateNotification) {
            //调整tittle出现的时机
              final newTransparent = _scrollController.offset < 100;
              if (newTransparent != _isTransparent) {
                setState(() {
                  _isTransparent = newTransparent;
                });
              }
            }
            return true;
          },
          child: ProfilePageBody(
            arguments: arguments,
            routeName: routeName,
            scrollController: _scrollController,
          ),
        ),
      ),
    );
  }
}

class ProfilePageBody extends StatefulWidget {
  final dynamic arguments;
  final String? routeName;
  final ScrollController scrollController;
  const ProfilePageBody({
    super.key,
    this.arguments,
    this.routeName,
    required this.scrollController,
  });
  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            expandedHeight:250,
            backgroundColor: Colors.blueGrey,
            //把这里的appbar的leading去掉
            leading: SizedBox.shrink(),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  background: _buildHeader(),
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
                tabs: const [
                  Tab(text: '主题'),
                  Tab(text: '回复'),
                  Tab(text: '收藏'),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                dividerHeight: 0,
                labelPadding: EdgeInsets.only(top: 12),
                indicatorWeight: 0.5,
                labelStyle: TextStyle(fontSize: 16),
                padding: EdgeInsets.only(left: 100, right: 100),
                
              ),
            ),
          ),
        ];
      },
      //设置body
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTopicList(),
          _buildReplyList(),
          _buildFavoriteList(),
        ],
      ),
    );
  }

//设置个人资料
  Widget _buildHeader() {
    return ProfileBuildHeader();
  }





  Widget _buildTopicList() {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            child: Text('主题'),
          );
        },
      ),
    );
  }

  Widget _buildReplyList() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('回复'),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteList() {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.green,
            child: Text('收藏'),
          );
        },
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
    return Container(
      color: Theme.of(context).canvasColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

