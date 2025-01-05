import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/enum/page_type_enum.dart';
import 'package:xingxing_forum_app/pages/main/appbar_widget.dart';
import 'package:xingxing_forum_app/pages/main/menu_drawer.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetHome(pageType: PageType.message),
      drawer: MenuDrawer(),
      body: MessagePageBody(),
    );
  }
}

class MessagePageBody extends StatelessWidget {
  const MessagePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('消息');
  }
}
