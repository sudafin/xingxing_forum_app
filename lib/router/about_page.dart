import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: Center(
        child: HYAboutPage(),
      ),
    );
  }
}

class HYAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('关于页',style: TextStyle(fontSize: 50,color: Colors.blue),),
        ElevatedButton(onPressed: (){
          //返回给跳转过来的页面
          var arguments = ModalRoute.of(context)!.settings.arguments;
          print(arguments);
          Navigator.pop(context,"关于页返回给跳转页的参数");
        }, child: Text('返回跳转过来的页面')),
      ],
    );
  }
}
