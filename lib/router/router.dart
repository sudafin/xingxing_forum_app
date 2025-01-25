import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../pages/error/error_page.dart';
import '../pages/profile/fans_follow.dart';
import '../pages/home/home_page.dart';
import '../pages/message/message_page.dart';
import '../pages/group/group_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/login/sign_up.dart';
import '../pages/login/sign_in.dart';
import '../pages/login/sign_spash_screen.dart';
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
  '/sign_spash_screen':(context) => const SignSplashScreen(),
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

//用于检查token是否存在,如果存在则跳转到主页,否则跳转到登录页面
class AuthWrapper extends StatefulWidget {
  //子组件
  final Widget child;
  //构造函数
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
    //isChecking为true,表示正在检查token,显示加载中,isChecking为false,表示检查完成,如果.有token就显示子组件,没有就在上面处理跳转到登录,这里需要使用SizeBox来占位,反之出现当前页面的留影
    return _isChecking 
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : _hasToken 
            ? widget.child
            : const SizedBox.shrink();
  }
}
