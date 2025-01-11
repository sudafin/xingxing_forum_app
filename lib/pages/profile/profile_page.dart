import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取当前路由名称
    final routeName = ModalRoute.of(context)?.settings.name;
    // 如果是push过来的获取传递的参数
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      drawer: MenuDrawer(),
      body: ProfilePageBody(arguments: arguments, routeName: routeName),
    );
  }
}

class ProfilePageBody extends StatefulWidget {
  final dynamic arguments;
  final String? routeName;
  const ProfilePageBody({super.key, this.arguments, this.routeName});
  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody>
    with TickerProviderStateMixin {
  late final _tabController;
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
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            forceElevated: innerBoxIsScrolled,
            expandedHeight: 400,
            leading: widget.routeName != '/profile'
                ? Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(Icons.menu, color: Colors.blue),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final opacity = (top - kToolbarHeight) / (400 - kToolbarHeight);
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

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 80, 20, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
          ),
          SizedBox(height: 16),
          Text(
            '用户名',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('个人简介'),
        ],
      ),
    );
  }

  Widget _buildTopicList() {
    return Container(
      height: 100,
      child: Text('主题'),
    );
  }

  Widget _buildReplyList() {
    return Container(
      color: Colors.blue,
    );
  }

  Widget _buildFavoriteList() {
    return Container(
      color: Colors.green,
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
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
