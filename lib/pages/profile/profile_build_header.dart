import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../../model/user_login_response.dart';
import '../../services/user_service.dart';

class ProfileBuildHeader extends StatefulWidget {
  final int? arguments;
  const ProfileBuildHeader({super.key, this.arguments});
  @override
  State<ProfileBuildHeader> createState() => ProfileBuildHeaderState();
}

class ProfileBuildHeaderState extends State<ProfileBuildHeader> {
  UserInfo? _user;
  int? _arguments;

  @override
  void initState() {
    super.initState();
    _arguments = widget.arguments;
    if (_arguments == null) {
      _getOwnUser(false);
    } else {
      _getOtherUser(_arguments!);
    }
  }

  Future<void> _getOwnUser(bool isRefresh) async {
    if (!isRefresh) {
      try {
        final userBox = await Hive.openBox('user');
        final localUser = userBox.get('user');
        if (localUser != null) {
          final userMap = Map<String, dynamic>.from(localUser as Map);
          if (mounted) {
            setState(() {
              _user = UserInfo.fromJson(userMap);
            });
          }
        } else {
          Log.error ("本地未找到用户数据");
        }
      } catch (e) {
        Log.error ("读取或解析用户数据出错：$e");
      }
    } else {
      // 刷新时先确保 _user 有效
      if (_user == null) {
        try {
          final userBox = await Hive.openBox('user');
          final localUser = userBox.get('user');
          if (localUser != null) {
            final userMap = Map<String, dynamic>.from(localUser as Map);
            _user = UserInfo.fromJson(userMap);
          } else {
            Log.error("刷新时本地未找到用户数据");
            return;
          }
        } catch (e) {
          Log.error("刷新时读取或解析本地用户数据出错：$e");
          return;
        }
      }
      if (_user == null) {
        Log.error("用户信息为空，无法刷新");
        return;
      }
      // 调用接口刷新用户数据
      try {
        UserInfo updatedUser = await UserService.
        getUserInfo(_user!.id);
        if (mounted) {
          setState(() {
            _user = updatedUser;
          });
        }
      } catch (e) {
        Log.error("获取用户信息失败：$e");
      }
    }
  }

  Future<void> _getOtherUser(int userId) async {
    try {
      UserInfo userInfo = await UserService.getUserInfo(userId);
      if (mounted) {
        setState(() {
          _user = userInfo;
        });
      }
    } catch (e) {
      Log.error("获取其他用户信息失败：$e");
    }
  }

  Future<void> refreshUser() async {
    if (_arguments == null) {
      print('刷新自己的用户信息');
      await _getOwnUser(true);
    } else {
      print('刷新其他用户信息');
      await _getOtherUser(_arguments!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAvatar(),
          SizedBox(height: 16),
          _buildIntroduction(),
          SizedBox(height: 8),
          //性别区域
          Container(
            margin: EdgeInsets.only(left: 18),
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey[400]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.male_outlined,
                color: Colors.lightBlue,
                size: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfomation(),
              SizedBox(width: 8),
              _buildButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAvatar() {
    return Container(
        padding: EdgeInsets.only(left: 2),
        height: 80,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
               //TODO 放大图片
                print('点击头像');
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey[400]!.withOpacity(0.3),
                radius: 50,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _user?.nickname ?? '未设置用户名',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Image.asset(
                        'assets/images/level1.png',
                        width: 30,
                        height: 20,
                      ),
                    ],
                  ),
                  Text(
                    'UID:${_user?.id}',
                    style: TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                  Text(
                    'IP属地:广东',
                    style: TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildIntroduction() {
    return Container(
      padding: EdgeInsets.only(left: 18),
      child: Text(
        _user?.bio ?? '未设置个人简介',
        style: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfomation() {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/fans_follow');
        }, child: 
          Column(
            children: [ 
              Text('${_user?.followCount ?? 0}',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
              Text('关注',style: TextStyle(fontSize: 14,color: Colors.grey[300]),),
            ],
          ),
          ),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, '/fans_follow');
          }, child: 
          Column(
            children: [ 
              Text('${_user?.fansCount ?? 0}',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
              Text('粉丝',style: TextStyle(fontSize: 14,color: Colors.grey[300]),),
            ],
          ),
          ),
          TextButton(onPressed: (){
           
          }, child: 
          Column(
            children: [ 
              Text('${_user?.likeCount ?? 0}',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
              Text('获赞',style: TextStyle(fontSize: 14,color: Colors.grey[300]),),
            ],
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Row(
      children: [
      Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[400]!.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white,width: 1),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile_edit');
          },
          child: Text('编辑资料',style: TextStyle(fontSize: 14,color: Colors.white),),
        ),
        ),
        SizedBox(width: 15),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[400]!.withOpacity(0.3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white,width: 1),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings_outlined,color: Colors.white,size: 20,),
              padding: EdgeInsets.zero,
              
            ),
          ),
        ),
      ],
    );
  }
}
