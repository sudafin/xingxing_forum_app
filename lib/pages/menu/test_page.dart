import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/services/test_service.dart';
import 'package:xingxing_forum_app/utils/log.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String res = "";
   bool isLoading = false;
  @override
  


  Future<void> getTest() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await TestService().getTest();
      Log.debug('测试结果: ${response['data']}');
      setState(() {
        isLoading = false;
        this.res = response['data'];
      });
    } catch (e) {
      Log.error('获取测试数据失败: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> postTest() async {
    final response = await TestService().postTest("测试");
    Log.debug('测试结果: ${response['data']}');
  }
  Future<void> putTest() async {
    final data = {
      "userName": "test",
      "id": 1,
    };
    final response = await TestService().putTest(data);
    Log.debug('测试结果: ${response['data']}');
  }
  Future<void> deleteTest() async {
    final response = await TestService().deleteTest(1);
    Log.debug('测试结果: ${response['data']}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getTest();
          },
          child: Text("测试"),
        ),
      ),
    );
  }
}
