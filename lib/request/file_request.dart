import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';
import 'dart:io';
import 'package:hive/hive.dart';

class FileRequest {
  static Storage storage = Storage(
    config: Config(
      // 设定网络请求重试次数
      retryLimit: 3,
    ),
  );

  static Future<String?> uploadFile(String filePath) async {
    final userBox = await Hive.openBox('user');
    String ossToken = userBox.get('ossToken');
    PutResponse response = await storage.putFile(
      File(filePath),
      ossToken,
    );
    return response.key;
  }
}
