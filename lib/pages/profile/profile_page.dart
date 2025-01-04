import 'package:flutter/material.dart';
import '../../widgets/menu_drawer.dart';
import '../../enum/page_type_enum.dart';
import '../../widgets/appbar_widget.dart';  
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  ProfilePageBody();
  }
}

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('我的');
  }
} 
