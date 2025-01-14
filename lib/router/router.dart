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
import '../pages/message/add_friend_page.dart';
import '../pages/screen/splash_screen.dart';
import '../widgets/post_page/post_page.dart';

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
  '/add_friend':(context) => const AddFriendPage(),
  '/post':(context) => const PostPage(),
  '/error':(context) => const ErrorPage(),
  
  };
}
