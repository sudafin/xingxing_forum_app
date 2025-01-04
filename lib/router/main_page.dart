import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: HomePage(),
        
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('首页',style: TextStyle(fontSize: 50,color: Colors.blue),),
        ElevatedButton(onPressed: (){
          final result = Navigator.pushNamed(context, '/detail',arguments: '首页传给详情页的参数');
          //拿到详情页返回的数据result
          result.then((value){
            print(value.toString());
          });
        }, child: Text('跳转到详情页')),
        ElevatedButton(onPressed: (){
          final result = Navigator.pushNamed(context, '/about',arguments: '首页传给关于页的参数');
          //拿到关于页返回的数据result
          result.then((value){
            print(value.toString());
          });
        }, child: Text('前进到关于页')),
      ],
    );
  }
}

