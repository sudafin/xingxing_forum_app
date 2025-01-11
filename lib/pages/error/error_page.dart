import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  '404',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '抱歉,您访问的页面不存在',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                  // 在group里,这里会返回group首页,因为main页面当前显示的group页面,如果直接group页面,底部导航栏会显示不出来
                  //其他页面同理,main显示哪个页面,那么返回哪个页面
                  //这里需要直接替换如果不替换那么按返回键会返回上一个页面
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    '返回首页',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ],
            ),
        ),
      );
  }
}

