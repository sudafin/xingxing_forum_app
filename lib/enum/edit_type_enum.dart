// 编辑类型枚举
enum EditType implements Comparable<EditType> {
  name(category: 0, typeName: "昵称"),
  gender(category: 1, typeName: "性别"),
  email(category: 2, typeName: "邮箱"),
  phone(category: 3, typeName: "手机号"),
  birthday(category: 4, typeName: "生日"),
  address(category: 5, typeName: "地址"),
  job(category: 6, typeName: "职业"),
  school(category: 7, typeName: "学校"),
  remark(category: 8, typeName: "简介");
  
  const EditType({required this.category,required this.typeName});  
  final int category;
  final String typeName;

  get editType => this;
  String get editTypeName => typeName;

  @override
  int compareTo(EditType other) {
    return category.compareTo(other.category);
  }

}