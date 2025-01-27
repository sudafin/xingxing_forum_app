import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/services/user_service.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import 'package:xingxing_forum_app/utils/show_toast.dart';
import 'package:hive/hive.dart';
import '../../utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:xingxing_forum_app/request/file_request.dart';


class SignInfo extends StatefulWidget {
  const SignInfo({super.key});

  @override
  State<SignInfo> createState() => _SignInfoState();
}

class _SignInfoState extends State<SignInfo> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  DateTime? _selectedDate;
  bool _isInputActive = false;
  final ScrollController _scrollController = ScrollController();

  // 添加焦点节点
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _birthdayFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _interestsFocus = FocusNode();
  final FocusNode _avatarFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _occupationFocus = FocusNode();
  final FocusNode _schoolFocus = FocusNode();


  List<String> _interestModulesOptions= [];
  final Set<String> _selectedInterestModules = {};

  


  late final AnimationController _animationController;
  late final AnimationController _scaleAnimationController;
  late final Animation<double> _scaleAnimation;

  File? _selectedAvatar;
  final double _avatarSize = 100.0;
  String? _avatarKey;


  late final AnimationController _shakeController;

  //获取板块
  Future<void> _getInterestModules() async {
    Box forumBox =  Hive.box('forum');
    _interestModulesOptions = forumBox.get('childrenForumList') ?? [];
  }
  @override
  void initState()  {
    super.initState();
    _getInterestModules();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _shakeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() => setState(() {}));
    // 添加焦点监听
    _setupFocusListeners();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleAnimationController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _setupFocusListeners() {
    final nodes = [_nameFocus, _birthdayFocus, _genderFocus, _interestsFocus, _avatarFocus, _bioFocus, _occupationFocus, _schoolFocus];
    for (var node in nodes) {
      node.addListener(() {
        if (node.hasFocus) {
          setState(() => _isInputActive = true);
          _scrollToActiveField(context);
        }
      });
    }
    _birthdayFocus.addListener(() {
      if (_birthdayFocus.hasFocus) {
        _birthdayFocus.unfocus();
      }
    });
  }

  void _scrollToActiveField(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = context.findRenderObject();
      if (renderObject != null) {
        final offsetY = renderObject.getTransformTo(null).getTranslation().y;
        final viewInsets = MediaQuery.of(context).viewInsets.bottom;

        // 计算需要滚动的距离
        final targetOffset =
            _scrollController.offset + offsetY - (viewInsets / 2);

        // 添加边界检查
        final maxScroll = _scrollController.position.maxScrollExtent;
        final minScroll = _scrollController.position.minScrollExtent;
        final clampedOffset = targetOffset.clamp(minScroll, maxScroll);

        _scrollController.animateTo(
          clampedOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: backgroundColor1,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            // 修改背景图片为动画版本
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _isInputActive ? -size.height * 0.5 : 0,
              child: Visibility(
                visible: !_isInputActive,
                child: Container(
                  height: size.height * 0.50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: primaryColor,
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/image.png",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //顶部appbar
            // 修改表单区域为动画版本
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _isInputActive ? 0 : size.height * 0.53,
              left: 0,
              right: 0,
              bottom:
                  _isInputActive ? MediaQuery.of(context).viewInsets.bottom : 0,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Transform.translate(
                      offset: Offset(_shakeController.value * 20 * sin(_shakeController.value * 3 * pi), 0),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          // 头像选择区域
                          GestureDetector(
                            onTap: _pickAvatar,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: _avatarSize,
                                  height: _avatarSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                    border: Border.all(
                                      color: primaryColor.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: _selectedAvatar != null
                                      ? ClipOval(
                                          child: Image.file(
                                            _selectedAvatar!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(
                                          Icons.camera_alt_outlined,
                                          size: 40,
                                          color: Colors.grey[500],
                                        ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                           
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 120,
                              ),
                              child: Column(
                                children: [
                                  // 真实姓名
                                  TextFormField(
                                    focusNode: _nameFocus,
                                    controller: _fullNameController,
                                    decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: '用户名',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500],
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.person_outline),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                      hintText: '请输入您的用户名',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '请输入用户名';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    focusNode: _bioFocus,
                                    controller: _bioController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      alignLabelWithHint: true,
                                      prefixIcon: Icon(Icons.edit_note_outlined),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(16, 20, 16, 12),
                                      hintText: '介绍一下自己吧...',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    maxLength: 100,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    focusNode: _occupationFocus,
                                    controller: _occupationController,
                                    decoration: InputDecoration(
                                      labelText: '职业',
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                      prefixIcon: Icon(Icons.work_outline),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                    ),
                                    maxLength: 10,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    focusNode: _schoolFocus,
                                    controller: _schoolController,
                                    decoration: InputDecoration(
                                      labelText: '学校',
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                      prefixIcon: Icon(Icons.school_outlined),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                    ),
                                    maxLength: 10,
                                  ),
                                  SizedBox(height: 15),
                                  // 生日选择
                                  TextFormField(
                                    focusNode: _birthdayFocus,
                                    controller: _birthdayController,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                      label: RichText(
                                        text: TextSpan(
                                          text: '出生日期',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[500],
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.cake),
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                      suffixIcon: 
                                       Icon(Icons.calendar_today),
                                    ),
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      _selectDate(context);
                                    },
                                  ),
                                  SizedBox(height: 15),

                                  // 性别选择
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '性别',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            _buildGenderOption('男'),
                                            SizedBox(width: 10),
                                            _buildGenderOption('女'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  // 兴趣爱好模板
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '选择你喜欢的板块',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        GridView.count(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8,
                                          childAspectRatio: 2.5,
                                          children:
                                              _interestModulesOptions.map((interest) {
                                            return _buildInterestChip(interest);
                                          }).toList(),
                                        ),
                                        if (_selectedInterestModules.isEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              '请至少选择一个板块',
                                              style: TextStyle(
                                                color: Colors.red[400],
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),

                                  // 提交按钮
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      focusNode: _avatarFocus,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () async {
                                        bool isValid = true;
                                        // 必填字段验证
                                        if (_fullNameController.text.isEmpty ){
                                          ShowToast.showToast('请输入用户名');
                                          isValid = false;
                                        }
                                        if (_birthdayController.text.isEmpty ){
                                          ShowToast.showToast('请选择出生日期');
                                          isValid = false;
                                        }
                                        if (_genderController.text.isEmpty ){
                                          ShowToast.showToast('请选择性别');
                                          isValid = false;
                                        }
                                        
                                        // 头像验证
                                        if (_selectedAvatar == null) {
                                          isValid = false;
                                          ShowToast.showToast('请选择头像');
                                        }

                                        // 兴趣爱好验证
                                        if (_selectedInterestModules.isEmpty) {
                                          isValid = false;
                                          ShowToast.showToast('请选择兴趣爱好');
                                        }
                                        if (!isValid) {
                                        //执行动画
                                          _triggerShakeAnimation();
                                          return;
                                        }
                                        try {
                                           await _insertUserInfo();
                                        } catch (e) {
                                          ShowToast.showToast('注册失败');
                                          Log.error('注册失败: $e');
                                        }
                                      },
                                      child: Text(
                                        '完成注册',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _genderController.text == gender
              ? Colors.white
              : Colors.grey[100],
          border: Border.all(
            color: _genderController.text == gender
                ? primaryColor
                : Colors.grey[300]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _genderController.text == gender
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() => _genderController.text = gender);
            },
            onTapDown: (_) => _scaleAnimationController.forward(),
            onTapUp: (_) => _scaleAnimationController.reverse(),
            onTapCancel: () => _scaleAnimationController.reverse(),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                height: 44,
                alignment: Alignment.center,
                child: Text(
                  gender,
                  style: TextStyle(
                    fontSize: 16,
                    color: _genderController.text == gender
                        ? primaryColor
                        : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInterestChip(String interest) {
    final isSelected = _selectedInterestModules.contains(interest);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale:
              1 + (_animationController.value * 0.15 * (isSelected ? 1 : -1)),
          child: child,
        );
      },
      child: InkWell(
        onTap: () => _toggleInterest(interest),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withOpacity(0.15)
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey[300]!,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            alignment: Alignment.center,
            child: Text(
              interest,
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey[600],
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterestModules.contains(interest)) {
        _selectedInterestModules.remove(interest);
      } else {
        _selectedInterestModules.add(interest);
      }
    });
    _animationController.forward(from: 0.5).then((_) {
      _animationController.reverse();
    });
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedAvatar = File(pickedFile.path);
      });
      try {
        _avatarKey = await FileRequest.uploadFile(pickedFile.path);
        if (_avatarKey != null) {
          ShowToast.showToast('头像上传成功');
        }
      } catch (e) {
        ShowToast.showToast('头像上传失败: ${e.toString()}');
      }
    }
  }

  void _triggerShakeAnimation() {
    _shakeController.forward(from: 0);
  }

  Map<String, dynamic> _buildRequestData() {
    return {
      'userName': _fullNameController.text,
      'birthday': _selectedDate?.toIso8601String().split('T')[0],
      'sex': _genderController.text,
      'interestModules': _selectedInterestModules.toList(),
      'avatar': _avatarKey,
      'bio': _bioController.text.isNotEmpty ? _bioController.text : null,
      'occupation': _occupationController.text.isNotEmpty 
          ? _occupationController.text 
          : null,
      'school': _schoolController.text.isNotEmpty 
          ? _schoolController.text 
          : null,
    };
  }

  Future<void> _insertUserInfo() async {
    final requestData = _buildRequestData();
    Log.debug('requestData: $requestData');
    var response = await UserService.insertUserInfo(requestData);
    if(response['code'] == 200){
      ShowToast.showToast('注册成功');
    }else{
      Log.error('注册失败: ${response['message']}');
    }
  }
}

