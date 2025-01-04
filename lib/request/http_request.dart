import 'package:dio/dio.dart';
import '../config/config.dart';
class HttpRequest{ 
  static final  BaseOptions _baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseURL,
    connectTimeout: Duration(seconds: HttpConfig.timeout) ,
  );
  static final Dio _dio = Dio(_baseOptions);
  static Future<T> request<T>(String url,{
    String method = 'get',
    Map<String, dynamic> params = const {},
  }) async{
   //创建请求方式
    final Options _options = Options(method: method,headers: {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
      "Accept": "application/json",
    });
    //拦截器
    Interceptor interceptor = InterceptorsWrapper(
    //请求拦截器
    onRequest: (options, handler){
      print("请求网址:${options.uri}");
      return handler.next(options);
    },
    //响应拦截器
    onResponse: (response, handler){
      return handler.next(response);
    },
    //错误拦截器
    onError: (error, handler){
      print("错误:${error.message}");
      return handler.next(error);
    },
    );
    _dio.interceptors.add(interceptor);
    try{
      final Response response = await _dio.request(url, queryParameters: params, options: _options);
      return response.data;
    }catch(e){
      rethrow;
    }
  }
}