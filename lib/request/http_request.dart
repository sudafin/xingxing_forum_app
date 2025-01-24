import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:xingxing_forum_app/utils/log.dart';
import 'package:xingxing_forum_app/router/router.dart';
import '../config/config.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../main.dart'; // 假设navigatorKey在main.dart中定义

class HttpRequest{ 
  static final  BaseOptions _baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseURL,
    connectTimeout: Duration(seconds: HttpConfig.timeout) ,
  );
  static final Dio _dio = Dio(_baseOptions);
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
    //拦截器
    Interceptor interceptor = InterceptorsWrapper(
    //请求拦截器
    onRequest: (options, handler) async {
      // 添加Token处理
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
    //响应拦截器
    onResponse: (response, handler) async {
      Log.debug ("请求响应拦截器:${response.data}");
      //如果响应码为401，表示未授权，跳转到登录页面
      if(response.statusCode == 401){
        final userBox = await Hive.openBox('user');
        await userBox.clear();
        // 使用全局导航key替代context
        if(navigatorKey.currentState != null){
          navigatorKey.currentState?.pushReplacementNamed('/sign_in');
        }
      }
      //如果响应码为403，表示没有权限，跳转到主页
      if(response.statusCode == 403){
        if(navigatorKey.currentState != null){
          navigatorKey.currentState?.pushReplacementNamed('/home');
        }
      }
      //如果响应码为404，表示资源未找到，跳转到主页
      if(response.statusCode == 404){
        if(navigatorKey.currentState != null){
          navigatorKey.currentState?.pushReplacementNamed('/home');
        }
      }
      
      return handler.next(response);
    },
    //请求错误拦截器
    onError: (error, handler){
      Log.debug ("请求错误拦截器:${error.message}");
      // 添加更详细的错误信息
      if (error.type == DioExceptionType.connectionError) {
        Log.error("无法连接到服务器，请检查网络连接或服务器地址");
      } else if (error.type == DioExceptionType.connectionTimeout) {
        Log.error("连接超时，请检查网络状况");
      } else {
        Log.error("请求失败，错误类型: ${error.type}");
      }
      return handler.next(error);
    },
    );
    _dio.interceptors.add(interceptor);
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