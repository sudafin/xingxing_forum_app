class LoginResponse {
  final UserInfo userInfo;
  final String token;
  final String refreshToken;

  LoginResponse({required this.userInfo, required this.token, required this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) 
    : userInfo = UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      token = json['token'] as String,
      refreshToken = json['refreshToken'] as String;

  Map<String, dynamic> toJson() => {
    'userInfo': userInfo.toJson(),
    'token': token,
    'refreshToken': refreshToken,
  };
  
}

class UserInfo {
  int id;
  String? nickName;
  String email;
  String? avatar;
  String? bio;
  bool? active;
  bool? admin;
  int? sex;
  String? ipAddress;
  String? address;
  DateTime? birthday;
  String? profession;
  String? school;
  int? followCount;
  int? fansCount;
  int? likeCount;


  UserInfo({
    required this.id,
    this.nickName,
    required this.email,
    this.avatar,
    this.bio,
    required this.active,
    required this.admin,
    required this.sex,
    required this.ipAddress,
    required this.address,
    required this.birthday,
    required this.profession,
    required this.school,
    required this.followCount,
    required this.fansCount,
    required this.likeCount,
  });

  UserInfo.fromJson(Map<String, dynamic> json) 
    : id = json['id'] is int ? json['id'] as int : int.parse(json['id'] as String),
      nickName = json['nickName'] as String?,
      email = json['email'] as String,
      avatar = json['avatar'] as String?,
      bio = json['bio'] as String?,
      active = json['active'] as bool?,
      admin = json['admin'] as bool?,
      sex = json['sex'] != null ? (json['sex'] is int ? json['sex'] as int : int.parse(json['sex'] as String)) : null,
      ipAddress = json['ipAddress'] as String?,
      address = json['address'] as String?,
      birthday = json['birthday'] != null ? DateTime.parse(json['birthday'] as String) : null,
      profession = json['profession'] as String?,
      school = json['school'] as String?,
      followCount = json['followCount'] != null ? (json['followCount'] is int ? json['followCount'] as int : int.parse(json['followCount'] as String)) : null,
      fansCount = json['fansCount'] != null ? (json['fansCount'] is int ? json['fansCount'] as int : int.parse(json['fansCount'] as String)) : null,
      likeCount = json['likeCount'] != null ? (json['likeCount'] is int ? json['likeCount'] as int : int.parse(json['likeCount'] as String)) : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickName': nickName,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'active': active,
      'admin': admin,
      'sex': sex,
      'ipAddress': ipAddress,
      'address': address,
      'birthday': birthday?.toIso8601String(),
      'profession': profession,
      'school': school,
      'followCount': followCount,
      'fansCount': fansCount,
      'likeCount': likeCount,
    };
  }
}
