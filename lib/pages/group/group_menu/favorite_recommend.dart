import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../../../store/store_viewmodel.dart';
import '../../../widgets/module_widget.dart';

class FavoriteRecommend extends StatefulWidget {
  const FavoriteRecommend({super.key});

  @override
  State<FavoriteRecommend> createState() => _FavoriteRecommendState();
}

class _FavoriteRecommendState extends State<FavoriteRecommend> {
  bool isHidden = false;
  @override
  Widget build(BuildContext context) {
  Color backgroundColor = context.watch<StoreViewModel>().theme == Brightness.light
              ? Colors.white
              : Colors.black;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
           //把ScrollView的高度设置为父容器的高度,也就是屏幕的高度
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Container(
              color: backgroundColor,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFavoriteItem(),
                  SizedBox(height: 20),
                  _buildRecommendItem(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildFavoriteItem(){
  //设置数据
    List<Widget> favoriteList = [];
    for(int i = 0; i < 5; i++){
      favoriteList.add(Container(
        decoration: BoxDecoration(
           border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline_rounded),color: Colors.blue,),  
            Text('模块$i'),
          ],
        ),
      ));
    }
    return Container(
    // 设置宽度不用设置高度,让GridView根据内容自适应高度
      width: SizeFit.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('我的收藏', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          GridView.builder(
            // 让GridView根据内容自适应高度  
            // 反之false它会占据整个屏幕,前提是外层设置高度,如果外层没有设置高度会报错,
            // 且还需要Expanded来设置Grid,这样它就会在这个容器内滑动,注意physic不要设置NeverScrollableScrollPhysics()
            shrinkWrap: true, 
            // 禁止GridView滚动
            physics: NeverScrollableScrollPhysics(), 
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              // 设置主轴间距
              mainAxisSpacing: 20, 
              // 设置交叉轴间距
              crossAxisSpacing: 9,
              // 设置子控件的宽高比
              childAspectRatio: 0.8,
            ),
            // 设置item数量
            itemCount: favoriteList.length,
            // 设置item的构造器
            itemBuilder: (context, index) {
              return favoriteList[index];
            },
          ),
        ],
      ),
    );
  }
  Widget _buildRecommendItem(){
  //设置数据
    List<Widget> recommendList = [];
    for(int i = 0; i < 10; i++){
      recommendList.add(Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
        //底部设置
           border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1))
        ),
        child: ModuleWidget(title: '模块$i', image: AssetImage('assets/images/emoji.png'), description: '描述$i',),
      ));
    }
    return Container(
      // 设置宽度不用设置高度,让GridView根据内容自适应高度
      width: SizeFit.screenWidth,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('推荐板块', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){
              setState(() {
                 isHidden = !isHidden;
              });
            }, child: Text('隐藏', style: TextStyle(fontSize: 14, color: Colors.grey),),),
          ],
        ),
          SizedBox(height: 10,),
          // 判断是否隐藏
           isHidden ? SizedBox.shrink() : ListView.builder(
            shrinkWrap: true, 
            // 禁止ListView滚动
            physics: NeverScrollableScrollPhysics(), 
            itemCount: recommendList.length,
            itemBuilder: (context, index) {
              return recommendList[index];
            },
          ),
        ],
      ),
    );
  }

} 