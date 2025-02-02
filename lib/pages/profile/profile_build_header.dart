import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/login_response.dart';

class ProfileBuildHeader extends StatefulWidget {
  const ProfileBuildHeader({super.key});
  @override
  State<ProfileBuildHeader> createState() => _ProfileBuildHeaderState();
}

class _ProfileBuildHeaderState extends State<ProfileBuildHeader> {
  UserDTO? _user;
  Future<UserDTO> _getUser() async {
    final userBox = await Hive.openBox('user');
    final user = userBox.get('user');
    final userMap = Map<String, dynamic>.from(user as Map);
    _user = UserDTO.fromJson(userMap);
    return _user!;
  }
  @override
  void initState() {
    super.initState();
    _getUser();
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
                        _user?.nickName ?? '未设置用户名',
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
              Text('100',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
              Text('关注',style: TextStyle(fontSize: 14,color: Colors.grey[300]),),
            ],
          ),
          ),
          TextButton(onPressed: (){
            Navigator.pushNamed(context, '/fans_follow');
          }, child: 
          Column(
            children: [ 
              Text('100',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
              Text('粉丝',style: TextStyle(fontSize: 14,color: Colors.grey[300]),),
            ],
          ),
          ),
          TextButton(onPressed: (){
           // TODO获赞的page
          }, child: 
          Column(
            children: [ 
              Text('100',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold),),
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
