import 'package:flutter/material.dart';
import '../../../enum/page_type_enum.dart';
import '../../../model/event_model.dart';
import 'package:event_bus/event_bus.dart';
import 'init_data/init_item.dart';

final eventBus = EventBus();

class AppBarWidgetHome extends StatefulWidget implements PreferredSizeWidget {
  final PageType pageType;
  const AppBarWidgetHome({super.key, required this.pageType});
  @override
  Size get preferredSize => Size.fromHeight(pageType.height.toDouble());
  @override
  State<AppBarWidgetHome> createState() => AppBarWidgetHomeState();
}

class AppBarWidgetHomeState extends State<AppBarWidgetHome> {
  @override
  Widget build(BuildContext context) {
    if (widget.pageType == PageType.message) {
      return MessageAppBar();
    } else if (widget.pageType == PageType.home) {
      return HomeAppBar();
    } else {
      return CommonAppBar(pageType: widget.pageType);
    }
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(5),
        ),
        //中间有个搜索图标
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.search,
              color: Color.fromARGB(214, 141, 141, 141),
              size: 21,
            ),
            SizedBox(
              width: 10,
            ),
            //跟图标对齐
            Text(
              '搜索',
              style: TextStyle(
                  color: Color.fromARGB(214, 141, 141, 141),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MessageAppBar extends StatelessWidget {
  const MessageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border.all(color: Color(0xFFFFFFFF), width: 0),
      //滑动时阴影消失
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: () {
          //打开菜单栏
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu, color: Colors.blue),
        alignment: Alignment.centerLeft,
      ),
      title: Text(
        '消息',
      ),
      actions: [
        // 添加好友
        IconButton(
          padding: EdgeInsets.only(right: 6),
          onPressed: () {
            //跳转添加好友页面
            Navigator.pushNamed(context, '/add_friend');
          },
          icon: Icon(Icons.person_add, color: Colors.blue),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key, required this.pageType});
  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border.all(color: Color(0xFFFFFFFF), width: 0),
      //滑动时阴影消失
      scrolledUnderElevation: 0,
      //点击推拉出菜单栏
      leading: IconButton(
        onPressed: () {
          //打开菜单栏
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
        ),
      ),
      //如果是群组页面index为1，则显示搜索框
      title: (pageType == PageType.group) ? SearchBar() : null,
      //听歌图标和邮件图标太靠右
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 6),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/task');
            },
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
          ),
        ),
      ],
    );
  }
}

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final PageController _pageController = PageController();
  int homeIndex = 0;
  int menuIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //监听页面滑动事件,如果滑动了,则切换到对应的appbar
    eventBus.on<HomePageChangeEvent>().listen((event) {
      setState(() {
        menuIndex = event.menuIndex;
        _pageController.animateToPage(
          menuIndex,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      });
    });
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AppBar(
          title: Image.asset(
            'assets/images/logo_name.png',
            scale: 1,
          ),
          centerTitle: true,
          shape: Border.all(color: Color(0xFFFFFFFF), width: 0),
          //滑动时阴影消失
          scrolledUnderElevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: IconButton(
              onPressed: () {
                // 打开菜单栏
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 6, bottom: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/task');
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTab(tabTitles[0]!, 0),
            _buildTab(tabTitles[1]!, 1),
            _buildTab(tabTitles[2]!, 2),
          ],
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          homeIndex = index;
          menuIndex = index;
        });
        //如果点击了appbar就发送事件
        eventBus.fire(
            HomePageChangeEvent(homeIndex: homeIndex, menuIndex: menuIndex));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: menuIndex == index ? Colors.blue : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: menuIndex == index ? Colors.blue : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
