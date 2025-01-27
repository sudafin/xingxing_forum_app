import 'package:xingxing_forum_app/utils/log.dart';

import '../request/http_request.dart';
import 'package:hive/hive.dart';
import '../model/forum_list.dart';

class ForumService {
  String prefix = 'forum';
  
  Future<List<ForumVO>?> getForum() async {
    try {
      final response = await HttpRequest.request('/$prefix/list', method: 'GET');
      if (response['code'] == 200) {
        // 将response['data']作为List处理
        List<dynamic> dataList = response['data'] as List<dynamic>;
        List<ForumVO> forumList = dataList
            .map((item) => ForumVO.fromJson(item as Map<String, dynamic>))
            .toList();
        Box forumBox = await Hive.openBox('forum');
        List<String> parentForumList = [];
         List<String> childrenForumList = [];
        for(var forum in forumList){
         parentForumList.add(forum.parentForumVO.name);
          for(var child in forum.childrenForumVOList){
            childrenForumList.add(child.name);
          }
        }
        forumBox.put('parentForumList', parentForumList);
        forumBox.put('childrenForumList', childrenForumList);
        return forumList;
      }
      return null;
    } catch (e) {
    Log.error('获取论坛列表失败: $e');
      return null;
    }
  }
}
