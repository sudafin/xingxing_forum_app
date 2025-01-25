import '../request/http_request.dart';

class SignInUpService {
  String prefix = "user";
  Future<Map<String, dynamic>> sendEmail(String email) async {
    final response = await HttpRequest.request('/$prefix/send/$email', method: 'GET');
    return response;
  }
  Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/register', method: 'POST', data: data);
    return response;
  }
  Future<Map<String, dynamic>> signIn(Map<String, dynamic> data) async {
    final response = await HttpRequest.request('/$prefix/login', method: 'POST', data: data);
    return response;
  }

}

