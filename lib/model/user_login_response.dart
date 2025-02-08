class LoginResponse {
  final UserInfo userInfo;
  final String token;
  final String refreshToken;
  final bool isFirstLogin;


  LoginResponse({required this.userInfo, required this.token, required this.refreshToken, required this.isFirstLogin});

  LoginResponse.fromJson(Map<String, dynamic> json)
      : userInfo = UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
        token = json['token'] as String,
        refreshToken = json['refreshToken'] as String,
        isFirstLogin = json['isFirstLogin'] as bool;

  Map<String, dynamic> toJson() => {
        'userInfo': userInfo.toJson(),
        'token': token,
        'refreshToken': refreshToken,
        'isFirstLogin': isFirstLogin,
      };
}

class UserInfo {
  final int id;
  final String nickname;
  final String avatar;
  final String? email;
  final String? bio;
  final bool? active;
  final bool? admin;
  final int? sex;
  final String? ipAddress;
  final String? address;
  final DateTime? birthday;
  final String? profession;
  final String? school;
  final int? followCount;
  final int? fansCount;
  final int? likeCount;

  UserInfo({
    required this.id,
    required this.nickname,
    required this.avatar,
    this.email,
    this.bio,
    this.active,
    this.admin,
    this.sex,
    this.ipAddress,
    this.address,
    this.birthday,
    this.profession,
    this.school,
    this.followCount,
    this.fansCount,
    this.likeCount,
  });

  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'] is int ? json['id'] as int : int.parse(json['id'].toString()),
        // nickname为必填字段，如缺失则默认赋值为空字符串，可根据实际需求做异常处理
        nickname = json['nickname'] as String? ?? '',
        // avatar为必填字段，如缺失则默认赋值为空字符串
        avatar = json['avatar'] as String? ?? '',
        // email、bio等都允许为空
        email = json['email'] as String?,
        bio = json['bio'] as String?,
        active = json['active'] as bool?,
        admin = json['admin'] as bool?,
        sex = json['sex'] != null
            ? (json['sex'] is int ? json['sex'] as int : int.tryParse(json['sex'].toString()))
            : null,
        ipAddress = json['ipAddress'] as String?,
        address = json['address'] as String?,
        birthday = json['birthday'] != null ? DateTime.tryParse(json['birthday'].toString()) : null,
        profession = json['profession'] as String?,
        school = json['school'] as String?,
        followCount = json['followCount'] != null
            ? (json['followCount'] is int ? json['followCount'] as int : int.tryParse(json['followCount'].toString()))
            : null,
        fansCount = json['fansCount'] != null
            ? (json['fansCount'] is int ? json['fansCount'] as int : int.tryParse(json['fansCount'].toString()))
            : null,
        likeCount = json['likeCount'] != null
            ? (json['likeCount'] is int ? json['likeCount'] as int : int.tryParse(json['likeCount'].toString()))
            : null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'avatar': avatar,
      'email': email,
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
