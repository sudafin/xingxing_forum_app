import 'package:flutter/material.dart';
import '../../enum/edit_type_enum.dart';

class ProfileEditDetail extends StatefulWidget {
  final EditType editType;
  const ProfileEditDetail({super.key, required this.editType});

  @override
  State<ProfileEditDetail> createState() => _ProfileEditDetailState();
}

class _ProfileEditDetailState extends State<ProfileEditDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editType.editTypeName),
      ),
    );
  }
}

