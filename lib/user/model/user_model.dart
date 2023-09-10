class UserModel {
  late String id;
  late String email;
  late String username;
  late String phone;
  late String gender;
  late DateTime birth;
  late String region;
  late String loginType;

  UserModel({
    this.id = '',
    this.email = '',
    this.username = '',
    this.phone = '',
    this.gender = '',
    required this.birth,
    this.region = '',
    this.loginType = '',
  });



  UserModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'],
        email = json['email'],
        username = json['username'],
        phone = json['phone'],
        gender = json['gender'],
        birth = DateTime.parse(json['date']),
        region = json['region'],
        loginType = json['loginType'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'gender': gender,
      'birth':
          '${birth.year}-${birth.month.toString().padLeft(2, '0')}-${birth.day.toString().padLeft(2, '0')}',
      'region': region,
      'loginType': loginType,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? phone,
    String? gender,
    DateTime? birth,
    String? region,
    String? loginType,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
      region: region ?? this.region,
      loginType: loginType ?? this.loginType,
    );
  }

  @override
  String toString() {
    return 'UserModel ('
        'model = id: $id, '
        'email: $email, '
        'username: $username, '
        'phone: $phone, '
        'gender: $gender'
        'birth: $birth'
        'region: $region'
        'loginType: $loginType'
        ')';
  }
}
