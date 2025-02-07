import '../request/http_request.dart';
import 'package:hive/hive.dart';
import '../model/user_login_response.dart';
class UserService {
  static String prefix = "user";
  static Future<Map<String, dynamic>> sendEmail(String email) async {
    final response = await HttpRequest.request('/$prefix/token/send/$email', method: 'GET');
    return response;
  }
  static Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/token/register', method: 'POST', data: data);
    return response;
  }
  static Future<Map<String, dynamic>> signIn(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/token/login', method: 'POST', data: data);
    return response;
  }
  static Future<void> getOssToken() async {
    final response = await HttpRequest.request('/$prefix/token/oss/', method: 'GET');
    final userBox = await Hive.openBox('user');
    userBox.put('ossToken', response['data']);
  }
  static Future<Map<String, dynamic>> insertUserInfo(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/info', method: 'POST', data: data);
    return response;
  }
  static Future<UserInfo> getUserInfo(int userId) async {
    final response = await HttpRequest.request('/$prefix/info/$userId', method: 'GET');
    UserInfo userInfo = UserInfo.fromJson(response['data']);  
    return userInfo;
  }
}

