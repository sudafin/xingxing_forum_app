import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import '../../../stores/store_viewmodel.dart';
import '../../../widgets/module_widget.dart';
import '../../../utils/size_fit.dart';
class SingleGame extends StatefulWidget {
  const SingleGame({super.key});

  @override
  State<SingleGame> createState() => _SingleGameState();
}

class _SingleGameState extends State<SingleGame> {
  @override
   Widget build(BuildContext context) {
    Color backgroundColor =
        context.watch<StoreViewModel>().theme == Brightness.light
            ? Colors.white
            : Colors.black;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Container(
            color: backgroundColor,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGameProductItem(),
              ],
            ),
          ),
        ),
      );
    });
  }
  Widget _buildGameProductItem() {
    List<Widget> list = [];
    for(int i = 0; i < 10; i++){
      list.add(Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
        //底部设置
           border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1))
        ),
        child: ModuleWidget(title: '模块$i', image: AssetImage('assets/images/emoji.png'), description: '描述$i',),
      ));
    }
    return SizedBox(
      // 设置宽度不用设置高度,让GridView根据内容自适应高度
      width: SizeFit.screenWidth,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('单机游戏板块', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          // 判断是否隐藏
            ListView.builder(
            shrinkWrap: true, 
            // 禁止ListView滚动
            physics: NeverScrollableScrollPhysics(), 
            itemCount: list.length,
            itemBuilder: (context, index) {
              return list[index];
            },
          ),
        ],
      ),
    );
  }
}