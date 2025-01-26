import '../request/http_request.dart';
import 'package:hive/hive.dart';
class SignInUpService {
  
  String prefix = "user";
  Future<Map<String, dynamic>> sendEmail(String email) async {
    final response = await HttpRequest.request('/$prefix/token/send/$email', method: 'GET');
    return response;
  }
  Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/token/register', method: 'POST', data: data);
    return response;
  }
  Future<Map<String, dynamic>> signIn(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/token/login', method: 'POST', data: data);
    return response;
  }
  Future<void> getOssToken() async {
    final response = await HttpRequest.request('/$prefix/token/oss/', method: 'GET');
    final userBox = await Hive.openBox('user');
    userBox.put('ossToken', response['data']);
  }
}

