import 'package:flutter/material.dart';
import 'package:xingxing_forum_app/utils/show_toast.dart';
import '../../utils/colors.dart';
import '../../services/sign_in_up_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String emailSuffix = "";
  String account = "";
  bool verifyCodeDown = false;
  final int _countdown = 60;
  final SignInUpService _signInUpService = SignInUpService();
  TextEditingController emailController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();
  
  Future<void> sendEmail() async {
    final response = await _signInUpService.sendEmail(account);
    if(response['code'] == 200){
      ShowToast.showToast("发送成功");
    }else{
      ShowToast.showToast("发送失败");
    }
  }
  Future<void> signUp(String email, String code) async {
    Map<String, dynamic> data = {
      "email": email,
      "code": code,
    };
    final response = await _signInUpService.signUp(data);
    if(response['code'] == 200){
      ShowToast.showToast("注册成功");
    }else{
      ShowToast.showToast(response['msg']);
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
              "你好,欢迎注册!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 37,
                color: textColor1,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "欢迎注册,去分享你的想法!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
            ),
            SizedBox(height: size.height * 0.04),
            myTextField("请输入邮箱", Colors.white, false, emailController),
            myTextField("请输入验证码", Colors.black26, true, verifyCodeController),
            const SizedBox(height: 10),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                 GestureDetector(
                 onTap: () {
                  if (emailController.text.isNotEmpty && verifyCodeController.text.isNotEmpty) {
                    //传入的是account,不是controller
                    signUp(account, verifyCodeController.text);
                  } else {
                    ShowToast.showToast("请输入完整且正确的邮箱和验证码");
                  }
                  },
                  child:
                   Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: emailController.text.isNotEmpty && verifyCodeController.text.isNotEmpty ? buttonColor : Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "注册",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
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
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      socialIcon("assets/images/google.png"),
                      socialIcon("assets/images/apple.png"),
                      socialIcon("assets/images/facebook.png"),
                    ],
                  ),
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

  Container myTextField(String hint, Color color, bool isVerifyCode,
      TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 22,
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
              fontSize: 16,
            ),
            suffixIcon: isVerifyCode
                ? _buildVerifyCode(color)
                : _buildEmailSuffic(controller)),
      ),
    );
  }

  Widget _buildVerifyCode(Color color) {
    return !verifyCodeDown
        ? TextButton(
            onPressed: () {
              setState(() {
              if(account.isNotEmpty && emailSuffix.isNotEmpty){
                account = account.contains('@')
                    ? account.split('@')[0] + emailSuffix
                    : account + emailSuffix;
                verifyCodeDown = true;
                //发送邮箱验证码请求
                sendEmail();
              }else{
                ShowToast.showToast("请输入完整且正确的邮箱");
              }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
              child: Text(
                "发送",
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          )
        : 
        //倒计数
        Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: TweenAnimationBuilder(
              duration: Duration(seconds: _countdown),
              tween: IntTween(begin: _countdown, end: 0),
              onEnd: () {
                setState(() {
                  verifyCodeDown = false;
                });
              },
              builder: (context, value, child) {
                return Text("${value.toInt()}",style: TextStyle(color: color,fontSize: 16),);
              },
            ),
          );
  }

  Widget _buildEmailSuffic(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 0)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text('邮箱后缀选择'),
          value: emailSuffix == "" ? null : emailSuffix,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          items: const [
            DropdownMenuItem(value: "@gmail.com", child: Text("@gmail.com")),
            DropdownMenuItem(
                value: "@hotmail.com", child: Text("@hotmail.com")),
            DropdownMenuItem(
                value: "@outlook.com", child: Text("@outlook.com")),
            DropdownMenuItem(value: "@yahoo.com", child: Text("@yahoo.com")),
            DropdownMenuItem(value: "@163.com", child: Text("@163.com")),
            DropdownMenuItem(value: "@qq.com", child: Text("@qq.com")),
          ],
          onChanged: (value) {
            setState(() {
              account = controller.text;
              emailSuffix = value!;
            });
          },
        ),
      ),
    );
  }
}
