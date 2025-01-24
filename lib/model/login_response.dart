class LoginResponse {
  final UserDTO userDTO;
  final String token;

  LoginResponse({required this.userDTO, required this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) 
    : userDTO = UserDTO.fromJson(json['userDTO'] as Map<String, dynamic>),
      token = json['token'] as String;

  Map<String, dynamic> toJson() => {
    'userDTO': userDTO.toJson(),
    'token': token,
  };
}

class UserDTO {
  int id;
  String? nickName;
  String email;
  String? avatar;
  String? bio;
  bool active;
  bool admin;

  UserDTO({
    required this.id,
    this.nickName,
    required this.email,
    this.avatar,
    this.bio,
    required this.active,
    required this.admin,
  });

  UserDTO.fromJson(Map<String, dynamic> json) 
    : id = json['id'] is int ? json['id'] as int : int.parse(json['id'] as String),
      nickName = json['nickName'] as String?,
      email = json['email'] as String,
      avatar = json['avatar'] as String?,
      bio = json['bio'] as String?,
      active = json['active'] as bool,
      admin = json['admin'] as bool;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickName': nickName,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'active': active,
      'admin': admin,
    };
  }
}
