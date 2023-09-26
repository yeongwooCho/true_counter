import 'package:true_counter/user/model/enum/sign_up_type.dart';

class KakaoRequestModel {
  SignUpType signUpType = SignUpType.kakao;
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
