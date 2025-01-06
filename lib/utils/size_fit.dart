import 'package:flutter/material.dart';

class SizeFit {
//屏幕尺寸
static double screenWidth = 0;
static double screenHeight = 0;
//状态栏高度
static double statusBarHeight = 0;
//rpx用于设计稿.1rpx = 屏幕宽度/750,用于屏幕适配,在设置尺寸时使用
static double rpx = 0;
//px用于代码.1px = 屏幕宽度/1080 * rpx
static double px = 0;

static void initialize(BuildContext context){
  final mediaQueryData = MediaQuery.of(context);
  screenWidth = mediaQueryData.size.width;
  screenHeight = mediaQueryData.size.height;
  statusBarHeight = mediaQueryData.padding.top;
  rpx = screenWidth / 750;
}
//将设计稿的尺寸转换为代码的尺寸
static double setRpx(double size){
  return rpx * size;
}
//将设计稿的尺寸转换为代码的尺寸
static double setPx(double size){
  return px * size;
}
} 

//扩展方法语法,将double类型扩展两个方法rpx和px,用于设置尺寸,double类型数据可以直接使用.rpx和.px就能获取到适配后的尺寸
/**
 *  20.rpx = 20 * SizeFit.setRpx(1)
 *  20.px = 20 * SizeFit.setPx(1)
 */
extension DoubleFit on double{
  double get rpx => SizeFit.setRpx(this);
  double get px => SizeFit.setPx(this);
}
extension IntFit on int{
  double get rpx => SizeFit.setRpx(toDouble());
  double get px => SizeFit.setPx(toDouble());
}
