// 页面类型枚举
enum PageType implements Comparable<PageType> {
  home(id: 1, name: "首页"),
  group(id: 2, name: "群组"),
  message(id: 3, name: "消息"),
  profile(id: 4, name: "个人信息");
  const PageType({required this.id,required this.name});  
  final int id;
  final String name;

  get pageType => this;
  String get pageName => name;

  @override
  int compareTo(PageType other) {
    return id.compareTo(other.id);
  }

}