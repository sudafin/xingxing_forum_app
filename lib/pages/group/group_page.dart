import 'package:flutter/material.dart';
import '../../enum/page_type_enum.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/menu_drawer.dart';
class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupPageBody();
  }
}
class GroupPageBody extends StatefulWidget {
  const GroupPageBody({super.key});

  @override
  State<GroupPageBody> createState() => _GroupPageBodyState();
}
class _GroupPageBodyState extends State<GroupPageBody> {
  @override
  Widget build(BuildContext context) {
    return Text('群组');
  }
} 
