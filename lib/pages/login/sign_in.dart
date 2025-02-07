import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/pages/main/main_page.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import '../../utils/colors.dart';
import '../../utils/show_toast.dart';
import '../../services/user_service.dart';
import '../../services/forum_service.dart';
import '../../model/user_login_response.dart';
import 'package:hive_flutter/hive_flutter.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserService signInUpService = UserService();
  Future<void> signIn(String email, String password) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };
    Map<String, dynamic> response = await UserService.signIn(data);
    if(response['code'] == 200){
      
      LoginResponse loginResponse = LoginResponse.fromJson(response['data']);
      //保存token用hive
       try {
         final userBox = Hive.box('user');
         var userData = loginResponse.userInfo.toJson();
         // 将id转换为字符串然后存储在hive,避免丢失精度
         userData['id'] = loginResponse.userInfo.id.toString();
         await userBox.put('token', loginResponse.token);
         await userBox.put('refreshToken', loginResponse.refreshToken);
         await userBox.put('user', userData);
        await UserService.getOssToken();
        await ForumService().getForum();
         //提示登录成功
         ShowToast.showToast("登录成功");
         //查看是否是初次登录,这里不需要清除堆栈,因为用户可能登录不对账号需要返回
         if(loginResponse.isFirstLogin){
          if(mounted){
            Navigator.pushNamed(context, '/sign_info');
          }
         }else{
           //如果是非初次登录,跳转到主页,需要清除堆栈
           if(mounted){
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainPage()), (route) => false);
           }
         }
       } catch (e) {
         Log.error('Hive错误: $e');
       }
    }else{
      Log.error(response['msg']);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
            child: ListView(
          children: [
            SizedBox(height: size.height * 0.03),
            Text(
              "你好,再次见面!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 37,
                color: textColor1,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "欢迎回来,继续分享你的想法!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
            ),
            SizedBox(height: size.height * 0.04),
            myTextField("请输入邮箱", Colors.white, false, _usernameController),
            myTextField("请输入密码", Colors.black26, true, _passwordController),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "忘记密码?               ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: textColor2,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                        await signIn(_usernameController.text, _passwordController.text);
                      } else {
                        ShowToast.showToast("请输入完整信息");
                      }
                    },
                    child:
                  Container(
                    width: size.width * 0.5,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "登录",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: size.width * 0.2,
                        color: Colors.black12,
                      ),
                      Text(
                        " 或者通过   ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor2,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: size.width * 0.2,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      socialIcon("assets/images/google.png"),
                      socialIcon("assets/images/apple.png"),
                      socialIcon("assets/images/facebook.png"),
                    ],
                  ),
                  SizedBox(height: size.height * 0.07),
                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        Navigator.pushNamed(context, '/sign_up');
                      }
                    },
                    child:
                  Text.rich(
                    TextSpan(
                      text: "没有账号? ",
                      style: TextStyle(
                        color: textColor2,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      children: const [
                       TextSpan(
                      text: "现在注册",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),)]
                    ),
                  ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }

  Container myTextField(String hint, Color color, bool isPassword, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 14,
            ),
       ),
      ),
    );
  }
}
