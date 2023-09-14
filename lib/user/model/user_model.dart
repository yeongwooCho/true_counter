import 'package:true_counter/common/variable/local_storage.dart';

class UserModel {
  late String id;
  late String email;
  late String username;
  late String phone;
  late String gender;
  late String birth;
  late String region;
  late String loginType;
  late String token;
  bool isDummy = false;

  static UserModel? current; // 현재 유저가 있는지 여부

  UserModel._internal(); // singleton pattern 을 위한 내부 생성자

  // 둘러 보기 용 dummy 유저 생성
  static void dummyLogin() {
    UserModel.current = UserModel.fromJson(
      json: {},
      isDummy: true,
    );
  }

  // singleton Pattern 데이터 && UserModel 생성을 담당하는 공장
  factory UserModel.fromJson({
    required Map<String, dynamic> json,
    required bool isDummy,
  }) {
    UserModel user = UserModel._internal();

    user.id = json['id'] ?? '';
    user.email = json['email'] ?? '';
    user.username = json['username'] ?? '';
    user.phone = json['phone'] ?? '';
    user.gender = json['gender'] ?? '';
    user.birth = json['date'] ?? '';
    user.region = json['region'] ?? '';
    user.loginType = json['loginType'] ?? '';
    user.token = json['token'] ?? '';
    user.isDummy = isDummy;

    if (user.token.isNotEmpty) {
      current = user;
    }

    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'gender': gender,
      'birth': birth,
      'region': region,
      'loginType': loginType,
    };
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

  Future<void> logout() async {
    UserModel.current = null;
    await LocalStorage.clear(
      key: LocalStorageKey.token,
    );
  }

  Future<void> autoLogin() async {
    await LocalStorage.write(
      key: LocalStorageKey.token,
      value: token,
    );
  }
}
