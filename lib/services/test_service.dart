import '../request/http_request.dart';
import '../utils/log.dart';


class TestService {
  Future<Map<String, dynamic>> getTest() async {
    try {
      final response = await HttpRequest.request('/test');
      return response;
    } catch (e) {
      Log.error('API请求失败: $e');
      rethrow;
    }
  }
  Future<Map<String, dynamic>> postTest(String data) async {
    final response = await HttpRequest.request('/test', method: 'POST', params: {"name": data});
    return response;
  }
  Future<Map<String, dynamic>> putTest(Map<String, dynamic> data) async {
    try {
      final response = await HttpRequest.request(
        '/test',
        method: 'PUT',
        data: data,
      );
      return response;
    } catch (e) {
      Log.error('PUT请求失败: $e');
      rethrow;
    }
  }
  Future<Map<String, dynamic>> deleteTest(int id) async {
    final response = await HttpRequest.request('/test/$id', method: 'DELETE');
    return response;
  }
} 