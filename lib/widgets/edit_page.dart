import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text('编辑页面'),
    );
  }
}
