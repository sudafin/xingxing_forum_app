import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double _appBarOpacity = 1.0;
  final double _maxScrollExtent = 200.0;
  int _count = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('透明度 AppBar'),
        backgroundColor: Colors.black.withOpacity(0),
        elevation: 0,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollNotification) {
            setState(() {
              _appBarOpacity = 1 - (notification.metrics.pixels / _maxScrollExtent);
                _appBarOpacity = 0;
              if (_appBarOpacity < 0) {
              } else if (_appBarOpacity > 1) {
                _appBarOpacity = 1;
              }
            });
          }
          return true;
        },
        child: ListView.builder(
          itemCount: _count,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Item $index'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}