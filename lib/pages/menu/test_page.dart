import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/services/test_service.dart';
import 'package:xingxing_forum_app/utils/log.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String res = "结果";
   bool isLoading = false;
  Future<void> getTest() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await TestService().getTest();
      Log.debug('测试结果: ${response['data']}');
      setState(() {
        isLoading = false;
        res = response['data'];
      });
    } catch (e) {
      Log.error('获取测试数据失败: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(res,style: TextStyle(fontSize: 20,color: Colors.blue),),
            ElevatedButton(
              onPressed: () {
                getTest();
                setState(() {
                  
                });
              },
              child: Text("测试"),
            ),
            
          ],
        ),
      ),
    );
  }
}
