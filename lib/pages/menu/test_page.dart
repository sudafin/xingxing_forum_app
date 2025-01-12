import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double _appBarOpacity = 1.0;
  final double _maxScrollExtent = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('透明度 AppBar'),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(_appBarOpacity),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollNotification) {
            setState(() {
              _appBarOpacity = 1 - (notification.metrics.pixels / _maxScrollExtent);
              if (_appBarOpacity < 0) {
                _appBarOpacity = 0;
              } else if (_appBarOpacity > 1) {
                _appBarOpacity = 1;
              }
            });
          }
          return true;
        },
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Item $index'));
          },
        ),
      ),
    );
  }
}