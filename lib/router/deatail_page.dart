import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: Center(
        child: HYDetailPage(),
      ),
    );
  }
}

class HYDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('详情页',style: TextStyle(fontSize: 50,color: Colors.blue),),
        ElevatedButton(onPressed: (){
         //拿到首页传过来的参数
         var arguments = ModalRoute.of(context)!.settings.arguments;
         print(arguments);
         //传给首页数据
          Navigator.pop(context,"详情页返回给跳转页的参数");
        }, child: Text('返回跳转过来的页面')),



        ElevatedButton(onPressed: (){
          final result = Navigator.pushNamed(context, '/about',arguments: '详情页传给关于页的参数');
          //拿到关于页返回的数据result
          result.then((value){
            print(value.toString());
          });
        }, child: Text('前进到关于页')),
      ],
    );
  }
}

