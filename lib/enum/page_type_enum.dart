// 页面类型枚举
enum PageType implements Comparable<PageType> {
  home(height: 90, name: "首页"),
  group(height: 50, name: "群组"),
  message(height: 50, name: "消息"),
  profile(height: 50, name: "个人信息");
  const PageType({required this.height,required this.name});  
  final int height;
  final String name;

  get pageType => this;
  String get pageName => name;

  @override
  int compareTo(PageType other) {
    return height.compareTo(other.height);
  }

}