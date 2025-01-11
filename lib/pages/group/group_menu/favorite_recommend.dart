import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:xingxing_forum_app/utils/size_fit.dart';
import '../../../store/store_viewmodel.dart';

class FavoriteRecommend extends StatelessWidget {
  const FavoriteRecommend({super.key});
  
  @override
  Widget build(BuildContext context) {
  Color backgroundColor = context.watch<StoreViewModel>().theme == Brightness.light
              ? Colors.white
              : Colors.black;
    return SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        height: SizeFit.screenHeight * 0.815,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          Text('我的收藏'),
        ],
      ),
      ),
    );
  }
}