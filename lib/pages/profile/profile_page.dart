import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../../stores/store_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/stores/store_drawer.dart';
import 'profile_build_header.dart';
import 'package:flutter/scheduler.dart';


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
        onDrawerChanged: (isOpened) {
          final store = Provider.of<StoreDrawer>(context, listen: false);
          store.setIsOpened(isOpened);
        },
        appBar: AppBar(
          leading: routeName == '/profile'
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
              : null,
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
        drawer: routeName != '/profile' ? MenuDrawer() : null,
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                final effectiveOffset = _scrollController.offset < 0 ? 0 : _scrollController.offset;
                final newOpacity = 1 - effectiveOffset / 210;
                if (newOpacity != _opacity) {
                  setState(() {
                    _opacity = newOpacity.clamp(0.0, 1.0);
                  });
                }
                final newTransparent = effectiveOffset < 100;
                if (newTransparent != _isTransparent) {
                  setState(() {
                    _isTransparent = newTransparent;
                  });
                }
              });
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
  bool _isLoading = false;
  late final TabController _tabController;
  // 声明 GlobalKey，用于获取 ProfileBuildHeader 的状态,在刷新时使用它去调用刷新方法
  final GlobalKey<ProfileBuildHeaderState> _headerKey = GlobalKey<ProfileBuildHeaderState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  Future<void> _handleRefresh() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1)); // 模拟刷新操作

    // 先检查 headerKey 的 currentState 是否可用
    if (_headerKey.currentState != null && _headerKey.currentState!.mounted) {
      await (_headerKey.currentState as ProfileBuildHeaderState).refreshUser();
    } else {
      // 如果不可用，可记录日志或执行其他刷新操作
      Log.error("ProfileBuildHeaderState 不可用，可能已被重建或 dispose");
    }


    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => true,
      onRefresh: _handleRefresh,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: NestedScrollView(
          floatHeaderSlivers: true,
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: false,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 250,
                backgroundColor: Colors.blueGrey,
                leading: SizedBox.shrink(),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return FlexibleSpaceBar(
                      // 传入 GlobalKey到ProfileBuildHeader中
                      background: ProfileBuildHeader(key: _headerKey, arguments: widget.arguments),
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
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildTopicList(),
              _buildReplyList(),
              _buildFavoriteList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicList() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 100,
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
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        shrinkWrap: true,
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
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
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
