import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../pages/error/error_page.dart';
import '../pages/main/main_page.dart';
import '../pages/profile/fans_follow.dart';
import '../pages/home/home_page.dart';
import '../pages/message/message_page.dart';
import '../pages/group/group_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/login/sign_up.dart';
import '../pages/login/sign_in.dart';
import '../pages/group/group_menu/module_detail.dart';
import '../pages/menu/about/about_page.dart';
import '../pages/menu/drafts/drafts_page.dart';
import '../pages/menu/favorite/favorite_page.dart';
import '../pages/menu/history/history_page.dart';
import '../pages/menu/settings/settings_page.dart';
import '../pages/menu/task/task_page.dart';
import '../widgets/search_page.dart';
import '../pages/message/follow_notified.dart';
import '../pages/message/favorite_notified.dart';
import '../pages/message/comment_notified.dart';
import '../pages/screen/splash_screen.dart';
import '../widgets/post_page/post_page.dart';
import '../widgets/post_detail_page.dart';
import '../pages/profile/profile_edit_page.dart';
import '../pages/message/chat_setting.dart';
import 'package:hive/hive.dart';

class RouterConstant{
  static final Map<String,WidgetBuilder> routerConstantMap = {
  '/splash':(context) => const SplashScreen(),
  '/main':(context) => const MainPage(),
  '/home':(context) => const HomePage(),
  '/message':(context) => const MessagePage(),
  '/group':(context) => const GroupPage(),
  '/profile':(context) => const ProfilePage(),
  '/about':(context) => const AboutPage(),
  '/drafts':(context) => const AuthWrapper(child: DraftsPage()),
  '/favorite':(context) => const AuthWrapper(child: FavoritePage()),
  '/history':(context) => const AuthWrapper(child: HistoryPage()),
  '/settings':(context) => const SettingsPage(),
  '/task':(context) => const AuthWrapper(child: TaskPage()),
  '/search':(context) => const AuthWrapper(child: SearchPage()),
  '/post':(context) => const AuthWrapper(child: PostPage()),
  '/post_detail':(context) => const AuthWrapper(child: PostDetailPage(postId: '')),
  '/error':(context) => const  ErrorPage(),
  '/follow_notified':(context) => const AuthWrapper(child: FollowNotifiedPage()),
  '/favorite_notified':(context) => const AuthWrapper(child: FavoriteNotifiedPage()),
  '/comment_notified':(context) => const AuthWrapper(child: CommentNotifiedPage()),
  '/profile_edit':(context) => const AuthWrapper(child: ProfileEdit()),
  '/chat_setting':(context) => const AuthWrapper(child: ChatSettingPage()),
  '/fans_follow':(context) => const AuthWrapper(child: FansFollowPage()),
  '/module_detail':(context) => const AuthWrapper(child:ModuleDetail()),
  '/sign_up':(context) => const SignUp(),
  '/sign_in':(context) => const SignIn(),
  };
}

class AuthWrapper extends StatefulWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
//等待检查token
  bool _isChecking = true;
//token是否存在
  bool _hasToken = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    try {
      //获取token
      final userBox = await Hive.openBox('user');
      //token是否存在
      _hasToken = userBox.get('token') != null;
    } catch (e) {
    Log.error("Token检查失败: $e");
    } finally {
      if (mounted) {
        setState(() {
        //将_isChecking设置为false,表示检查完成
          _isChecking = false;
          //如果token不存在，跳转到登录页面
          if (!_hasToken) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed('/sign_in');
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //如果正在检查token，显示加载中
    return _isChecking 
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : widget.child;
  }
}
