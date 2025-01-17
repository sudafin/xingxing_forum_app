import 'package:flutter/material.dart';
import '../pages/error/error_page.dart';
import '../pages/main/main_page.dart';
import '../pages/home/home_page.dart';
import '../pages/message/message_page.dart';
import '../pages/group/group_page.dart';
import '../pages/profile/profile_page.dart';
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

class RouterConstant{
  static final Map<String,WidgetBuilder> routerConstantMap = {
  '/splash':(context) => const SplashScreen(),
  '/main':(context) => const MainPage(),
  '/home':(context) => const HomePage(),
  '/message':(context) => const MessagePage(),
  '/group':(context) => const GroupPage(),
  '/profile':(context) => const ProfilePage(),
  '/about':(context) => const AboutPage(),
  '/drafts':(context) => const DraftsPage(),
  '/favorite':(context) => const FavoritePage(),
  '/history':(context) => const HistoryPage(),
  '/settings':(context) => const SettingsPage(),
  '/task':(context) => const TaskPage(),
  '/search':(context) => const SearchPage(),
  '/post':(context) => const PostPage(),
  '/post_detail':(context) => const PostDetailPage(postId: ''),
  '/error':(context) => const ErrorPage(),
  '/follow_notified':(context) => const FollowNotifiedPage(),
  '/favorite_notified':(context) => const FavoriteNotifiedPage(),
  '/comment_notified':(context) => const CommentNotifiedPage(),
  '/profile_edit':(context) => const ProfileEdit(),
  '/chat_setting':(context) => const ChatSettingPage(),
  };
}
