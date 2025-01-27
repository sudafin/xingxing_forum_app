class ForumVO {
  final ForumParentVO parentForumVO;
  final List<ForumParentVO> childrenForumVOList;

  ForumVO({
    required this.parentForumVO, 
    required this.childrenForumVOList
  });

  ForumVO.fromJson(Map<String, dynamic> json)
    : parentForumVO = ForumParentVO.fromJson(json['parentForumVO'] as Map<String, dynamic>),
      childrenForumVOList = (json['childrenForumVOList'] as List<dynamic>)
          .map((e) => ForumParentVO.fromJson(e as Map<String, dynamic>))
          .toList();

  Map<String, dynamic> toJson() => {
    'parentForumVO': parentForumVO.toJson(),
    'childrenForumVOList': childrenForumVOList.map((e) => e.toJson()).toList(),
  };
}

class ForumParentVO {
  String id;
  String name;
  String? description;
  String? avatar;
  String parentId;
  int postCount;
  int threadCount;
  String? lastPostId;
  String lastPostTime;

  ForumParentVO({
    required this.id,
    required this.name,
    this.description,
    this.avatar,
    required this.parentId,
    required this.postCount,
    required this.threadCount,
    this.lastPostId,
    required this.lastPostTime,
  });

  ForumParentVO.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      name = json['name'] as String,
      description = json['description'] as String?,
      avatar = json['avatar'] as String?,
      parentId = json['parentId'] as String,
      postCount = json['postCount'] as int,
      threadCount = json['threadCount'] as int,
      lastPostId = json['lastPostId'] as String?,
      lastPostTime = json['lastPostTime'] as String;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'avatar': avatar,
    'parentId': parentId,
    'postCount': postCount,
    'threadCount': threadCount,
    'lastPostId': lastPostId,
    'lastPostTime': lastPostTime,
  };
}

class ForumListResponse {
  final List<ForumVO> data;

  ForumListResponse({required this.data});

  ForumListResponse.fromJson(Map<String, dynamic> json)
    : data = (json['data'] as List<dynamic>)
        .map((e) => ForumVO.fromJson(e as Map<String, dynamic>))
        .toList();

  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toJson()).toList(),
  };
}