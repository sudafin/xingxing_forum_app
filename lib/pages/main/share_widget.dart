import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:clipboard/clipboard.dart';
import '../../../utils/size_fit.dart';
import '../../../store/store_viewmodel.dart';
import 'package:provider/provider.dart';


//分享组件
class ShareWidget extends StatelessWidget {
  const ShareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.watch<StoreViewModel>().theme == Brightness.dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
      ),
      width: SizeFit.screenWidth,
      height: SizeFit.screenHeight*0.20,
      child: Column(
        children: [
        //显示分享途径的icon
          Container(
           margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: SizeFit.screenWidth,
            height: SizeFit.screenHeight*0.12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) => displayShareIcon(index)),
            ),
          ),
          SizedBox(height: SizeFit.screenHeight*0.01,child: Container(color: Colors.grey[300],),),
          //设置返回按钮
          Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: SizeFit.screenWidth,
            height: SizeFit.screenHeight*0.05,
            //取消按钮
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消',style: TextStyle(fontSize: 16,color: Colors.blue),), // 设置字体为粗体
            ),
          ),
        ],
      ),
    );

  }
  //设置分享途径的icon
  Widget displayShareIcon(int index){
  switch(index){
    case 0:
      return 
      Column(
        children: [
          IconButton(onPressed: (){
            //分享打开微博软件
            const intent = AndroidIntent(
              action: 'action_view',
              package: 'com.sina.weibo',
              data: 'https://www.weibo.com',
            );
            intent.launch().catchError((e) => Fluttertoast.showToast(msg: '微博软件未安装'));
           
          }, icon: Icon(FontAwesomeIcons.weibo,size: 24,color: Colors.blue,),),
          Text('微博',style: TextStyle(fontSize: 16),), // 设置字体为粗体
        ],
      );
    case 1:
      return 
      Column( 
        children: [
          IconButton(onPressed: (){
            //分享打开微信软件
            const intent = AndroidIntent(
              action: 'action_view',
              package: 'com.tencent.mm',
              data: 'https://www.wechat.com',
            );
            intent.launch().catchError((e) => Fluttertoast.showToast(msg: '微信软件未安装'));
          }, icon: Icon(FontAwesomeIcons.weixin,size: 24,color: Colors.blue,),),
          Text('微信',style: TextStyle(fontSize: 16),), // 设置字体为粗体
        ],
      );
    case 2:
      return 
      Column(
        children: [
          IconButton(onPressed: (){
            //分享打开QQ软件
            const intent = AndroidIntent(
              action: 'action_view',
              package: 'com.tencent.mobileqq',
              data: 'https://www.qq.com',
            );
            intent.launch().catchError((e) => Fluttertoast.showToast(msg: 'QQ软件未安装'));
          }, icon: Icon(FontAwesomeIcons.qq,size: 24,color: Colors.blue,),),
          Text('QQ',style: TextStyle(fontSize: 16),), // 设置字体为粗体
        ],
      );
    case 3:
      return 
      Column(
        children: [
          IconButton(onPressed: (){
            //复制链接
            FlutterClipboard.copy('https://www.baidu.com');
            Fluttertoast.showToast(msg: '复制成功');
          }, icon: Icon(FontAwesomeIcons.share,size: 24,color: Colors.blue,),),
          Text('复制链接',style: TextStyle(fontSize: 16),), // 设置字体为粗体
        ],
      );
    default:
      return SizedBox.shrink();
  }
}
}
