import 'package:true_counter/common/model/enum/login_type.dart';

class KakaoRequestModel {
  LoginType loginType = LoginType.kakao;
  final int? uid;
  final String? token;
  String? email;

  KakaoRequestModel({
    required this.uid,
    required this.token,
    this.email = '',
  });

  @override
  String toString() {
    return 'KakaoRequestModel = { uid: $uid, token: $token, email: $email }';
  }
}
