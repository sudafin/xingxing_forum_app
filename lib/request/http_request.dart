import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import 'package:xingxing_forum_app/utils/show_toast.dart';
import '../config/config.dart';
import 'package:hive/hive.dart';
import '../main.dart'; // navigatorKey在main.dart中定义

class HttpRequest{ 
  static final  BaseOptions _baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseURL,
    connectTimeout: Duration(seconds: HttpConfig.timeout) ,
  );
  static final Dio _dio = Dio(_baseOptions)..interceptors.add(
    InterceptorsWrapper(
    //请求拦截器
      onRequest: (options, handler) async {
        try {
          final userBox = await Hive.openBox('user');
          String? token = userBox.get('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          Log.error("获取Token失败: $e");
        }
        
        Log.debug ("请求网址:${options.uri}");
        return handler.next(options);
      },
      //响应拦截器,statusCode为2xx会进入响应拦截器
      onResponse: (response, handler) async {
        return handler.next(response);
      },
      //错误拦截器,错误码不是2xx时进入的拦截器
      onError: (error, handler) async {
      // 处理400错误,接收后端返回的错误信息
        if(error.response?.statusCode == 400){
          ShowToast.showToast(error.response?.data['msg']);
          return handler.next(error);
        }
        // 处理401未授权错误
        if (error.response?.statusCode == 401) {
          final userBox = await Hive.openBox('user');
          String? refreshToken = userBox.get('refreshToken');
          try{
            final response = await HttpRequest.request(
            '/user/token/refresh',
            method: 'GET',
            params: {'refreshToken': refreshToken},
          );
          String accessToken = response['data'];
          // 更新token
            await userBox.put('token', accessToken);
            // 使用新token重试原始请求
            final opts = Options(
              method: error.requestOptions.method,
              headers: {
                ...error.requestOptions.headers,
                'Authorization': 'Bearer $accessToken'
              }
            );
            final retryResponse = await _dio.request(
              error.requestOptions.path,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
              options: opts,
            );
            return handler.resolve(retryResponse);
          }catch(e){
            //如果错误说明refreshToken过期，清除用户信息，跳转到登录页面
            ShowToast.showToast('登录过期，请重新登录');
            await userBox.clear();
            navigatorKey.currentState?.pushReplacementNamed('/sign_in');
            return handler.next(error);
          }
        }
        //如果响应码为403，表示没有权限，跳转到主页
        if(error.response?.statusCode == 403){
          if(navigatorKey.currentState != null){
            navigatorKey.currentState?.pushReplacementNamed('/home');
          }
        }
        //如果响应码为404，表示资源未找到，跳转到主页
        if(error.response?.statusCode == 404){
          if(navigatorKey.currentState != null){
            navigatorKey.currentState?.pushReplacementNamed('/home');
          }
        }

        //如果请求失败，打印错误信息
        if (error.type == DioExceptionType.connectionError) {
          Log.error("无法连接到服务器，请检查网络连接或服务器地址");
        } else if (error.type == DioExceptionType.connectionTimeout) {
          Log.error("连接超时，请检查网络状况");
        } else {
          Log.error("请求失败，错误类型: ${error.type}");
        }
        return handler.next(error);
      },
    )
  );
  //请求方法
  static Future<T> request<T>(String url,{
    String method = 'get',
    Map<String, dynamic> params = const {},
    dynamic data,
    Map<String, dynamic> headers = const {},
  }) async{
   if(data is Map<String, dynamic>){
    data = jsonEncode(data);
   }
   
   //创建请求方式
    final Options options = Options(
      method: method,
      headers: {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
        "Accept": "application/json",
        ...headers,
      },
    );
    try{
      final Response response = await _dio.request(
        url,
        queryParameters: params,
        options: options,
        data: data,
      );
      return response.data;
    }catch(e){
      Log.error("请求失败:${e.toString()}");
      rethrow;
    }
  }
}