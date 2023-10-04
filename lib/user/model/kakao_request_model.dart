import 'package:true_counter/user/model/enum/sign_up_type.dart';

class KakaoRequestModel {
  SignUpType signUpType = SignUpType.kakao;
  int? uid;
  String? token;
  String? email;
  String? error;

  KakaoRequestModel({
    this.uid,
    this.token,
    this.email,
    this.error,
  });

  @override
  String toString() {
    return 'KakaoRequestModel = { uid: $uid, token: $token, email: $email, error: $error}';
  }
}
