import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../enum/edit_type_enum.dart';

class ProfileEditDetail extends StatefulWidget {
  final EditType editType;
  final String? initialValue;
  const ProfileEditDetail(
      {super.key, required this.editType, this.initialValue});

  @override
  State<ProfileEditDetail> createState() => _ProfileEditDetailState();
}

class _ProfileEditDetailState extends State<ProfileEditDetail> {
  final TextEditingController _textController = TextEditingController();
  bool isSave = false;
  bool isMale = false;
  bool isFemale = false;
  Result? selectedCity;
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    //筛选初始值
    switch (widget.editType) {
      case EditType.name:
        _textController.text = widget.initialValue ?? '';
        break;
      case EditType.gender:
        if (widget.initialValue == '男') {
          isMale = true;
        } else if (widget.initialValue == '女') {
          isFemale = true;
        }
        break;
      case EditType.email:
        _textController.text = widget.initialValue ?? '';
        break;
      case EditType.phone:
        _textController.text = widget.initialValue ?? '';
        break;
      case EditType.birthday:
        selectedDate = DateTime.parse(widget.initialValue ?? '');
        
        break;
      case EditType.address:
        selectedCity = Result(
            provinceName: widget.initialValue ?? '',
            cityName: '',
            areaName: '');
        break;
      case EditType.job:
        _textController.text = widget.initialValue ?? '';
        break;
      case EditType.school:
        _textController.text = widget.initialValue ?? '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑${widget.editType.editTypeName}'),
        toolbarHeight: 50,
        actions: [
          //保存按钮
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: isSave
                  ? InkWell(
                      onTap: () {
                        switch (widget.editType) {
                          //TODO 保存操作
                          case EditType.name:
                            break;
                          case EditType.gender:
                            break;
                          case EditType.email:
                            break;
                          case EditType.phone:
                            break;
                          case EditType.birthday:
                            break;
                          case EditType.address:
                            break;
                          case EditType.job:
                            break;
                          case EditType.school:
                            break;
                        }
                      },
                      child: Text(
                        '保存',
                        style: TextStyle(color: Colors.blue),
                      ))
                  : Text(
                      '保存',
                      style: TextStyle(color: Colors.grey),
                    ))
        ],
      ),
      body: switch (widget.editType) {
        EditType.name => _buildNickName(),
        EditType.gender => _buildGender(),
        EditType.email => _buildEmail(),
        EditType.phone => _buildPhone(),
        EditType.birthday => _buildBirthday(),
        EditType.address => _buildAddress(),
        EditType.job => _buildJob(),
        EditType.school => _buildSchool(),
      },
    );
  }

  Widget _buildNickName() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('七天内只能修改一次昵称',
              style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: '请输入昵称',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xFFFAFAFA),
              filled: true,
              isDense: true,
              //显示字数的字体设置
              counterStyle: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            //最多输入多少且会自动显示当前字数
            maxLength: 10,
            controller: _textController,
            onChanged: (value) {
              setState(() {
                isSave = value.isNotEmpty;
              });
            },
          ),
          SizedBox(height: 10),
          Text('昵称长度为1-10个字符,请不要使用特殊符号如@#^&*()_+-=[]{}|\\:;"\'<>,.?/等',
              style: TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildGender() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请选择性别', style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 10),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = true;
                    isFemale = false;
                    isSave = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('男',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      isMale
                          ? Icon(
                              Icons.check_outlined,
                              color: Colors.blue,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
                indent: 8,
                endIndent: 8,
                color: Colors.grey[200],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFemale = true;
                    isMale = false;
                    isSave = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('女',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      isFemale
                          ? Icon(
                              Icons.check_outlined,
                              color: Colors.blue,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请输入邮箱', style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: '请输入邮箱',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xFFFAFAFA),
              filled: true,
              isDense: true,
              //显示字数的字体设置
              counterStyle: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            //最多输入多少且会自动显示当前字数
            maxLength: 30,
            controller: _textController,
            onChanged: (value) {
              setState(() {
                isSave = value.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPhone() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请输入手机号', style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: '请输入手机号',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xFFFAFAFA),
              filled: true,
              isDense: true,
              //显示字数的字体设置
              counterStyle: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            //最多输入多少且会自动显示当前字数
            maxLength: 11,
            controller: _textController,
            onChanged: (value) {
              setState(() {
                isSave = value.isNotEmpty;
              });
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildBirthday() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text('请选择您的生日',
                style: TextStyle(fontSize: 16, color: Colors.black54)),
          ),
          SizedBox(height: 10),
          //日期选择器
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  // 处理选择的日期
                  setState(() {
                    this.selectedDate = selectedDate;
                    isSave = true;
                  });
                }
              });
            },
            child: Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      '${selectedDate?.year ?? '请选择生日'}年${selectedDate?.month ?? '请选择生日'}月${selectedDate?.day ?? '请选择生日'}日'),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
                    '${selectedCity?.provinceName ?? '请选择地区'} ${selectedCity?.cityName ?? '请选择地区'} ${selectedCity?.areaName ?? '请选择地区'}',
                    style: TextStyle(fontSize: 16, color: Colors.black54))),
          ),
          SizedBox(height: 10),
          //地区选择器
          ElevatedButton(
            onPressed: () {
              getResult();
            },
            child: Text('选择地区', style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Future<Result?> getResult() async {
    Result? result = await CityPickers.showCityPicker(
      context: context,
    );
    setState(() {
      selectedCity = result;
      isSave = true;
    });
    return result;
  }

  Widget _buildJob() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请输入工作', style: TextStyle(fontSize: 14, color: Colors.black54)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                hintText: '请输入工作',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                fillColor: Color(0xFFFAFAFA),
                filled: true,
                isDense: true,
                counterStyle: TextStyle(fontSize: 12, color: Colors.black54)),
            controller: _textController,
            maxLength: 10,
            onChanged: (value) {
              setState(() {
                isSave = value.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSchool() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('请输入学校', style: TextStyle(fontSize: 14, color: Colors.black54)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(hintText: '请输入学校', hintStyle: TextStyle(color: Colors.grey, fontSize: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), fillColor: Color(0xFFFAFAFA), filled: true, isDense: true, counterStyle: TextStyle(fontSize: 12, color: Colors.black54)),
            controller: _textController,
            maxLength: 10,
            onChanged: (value) {
              setState(() {
                isSave = value.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }
}
