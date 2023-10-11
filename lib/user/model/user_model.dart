import 'dart:io';

import 'package:true_counter/common/model/app_info.dart';
import 'package:true_counter/user/model/enum/role_type.dart';
import 'package:true_counter/user/model/enum/sign_up_type.dart';
import 'package:true_counter/user/model/token_model.dart';

class UserModel {
  late String email;
  late String nickname;
  late DateTime birthday;
  late String phone;
  late bool gender;
  late String region;
  late SignUpType signupType;
  late RoleType roleType;

  bool isDummy = false;

  static UserModel? current; // 현재 유저가 있는지 여부

  UserModel._internal(); // singleton pattern 을 위한 내부 생성자

  // 둘러 보기 용 dummy 유저 생성
  static void dummyLogin() {
    UserModel.current = UserModel.fromJson(
      json: {
        "birthday": "2023-09-28",
      },
      isDummy: true,
    );
  }

  // singleton Pattern 데이터 && UserModel 생성을 담당하는 공장
  factory UserModel.fromJson({
    required Map<String, dynamic> json,
    bool isDummy = false,
  }) {
    UserModel user = UserModel._internal();
    user.email = json['email'] ?? '';
    user.nickname = json['nickname'] ?? '';
    user.birthday = DateTime.parse(json['birthday']);
    user.phone = json['phone'] ?? '';
    user.gender = json['gender'] ?? true;
    user.region = json['region'] ?? '';
    user.signupType = SignUpType.getType(type: json['signupType'] ?? '');
    user.roleType = RoleType.getType(type: json['role'] ?? '');
    user.isDummy = isDummy;

    if (TokenModel.instance != null) current = user;

    return user;
  }

  static Map<String, String> getHeaders({
    bool isJson = true,
  }) {
    Map<String, String> headers = {
      'App-Version': '${AppInfo.currentVersion}',
      'device': Platform.isIOS ? 'ios' : 'android',
    };

    if (isJson) {
      headers['Content-Type'] = 'application/json';
    }

    if (TokenModel.instance != null) {
      headers['Authorization'] = 'Bearer ${TokenModel.instance?.accessToken}';
    }

    return headers;
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'phone': phone,
      'gender': gender,
      'birthday': birthday,
      'region': region,
      'signupType': signupType,
      'roleType': roleType,
    };
  }

  @override
  String toString() {
    return 'UserModel ('
        'email: $email, '
        'nickname: $nickname, '
        'phone: $phone, '
        'gender: $gender'
        'birthday: $birthday'
        'region: $region'
        'signupType: $signupType'
        'roleType: $roleType'
        'isDummy: $isDummy'
        ')';
  }
}
