class LoginResponse {
  final UserDTO userDTO;
  final String token;
  final String refreshToken;

  LoginResponse({required this.userDTO, required this.token, required this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) 
    : userDTO = UserDTO.fromJson(json['userDTO'] as Map<String, dynamic>),
      token = json['token'] as String,
      refreshToken = json['refreshToken'] as String;

  Map<String, dynamic> toJson() => {
    'userDTO': userDTO.toJson(),
    'token': token,
    'refreshToken': refreshToken,
  };
  
}

class UserDTO {
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

  UserDTO({
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
  });

  UserDTO.fromJson(Map<String, dynamic> json) 
    : id = json['id'] is int ? json['id'] as int : int.parse(json['id'] as String),
      nickName = json['nickName'] as String?,
      email = json['email'] as String,
      avatar = json['avatar'] as String?,
      bio = json['bio'] as String?,
      active = json['active'] as bool?,
      admin = json['admin'] as bool?,
      sex = json['sex'] as int?,
      ipAddress = json['ipAddress'] as String?,
      address = json['address'] as String?,
      birthday = json['birthday'] != null ? DateTime.parse(json['birthday'] as String) : null,
      profession = json['profession'] as String?,
      school = json['school'] as String?;


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
