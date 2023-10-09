import 'package:true_counter/user/model/enum/sign_up_type.dart';

abstract class UserRepositoryInterface {
  Future<bool> verifyUser({
    required String email,
  });

  Future<bool> userInfo();

  Future<bool> signUp({
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required bool gender,
    required String region,
    required SignUpType signUpType,
  });

  Future<bool> signIn({
    required String email,
    required String password,
  });

  Future<bool> tokenSignIn();

  Future<bool> tokenReissue();

  Future<bool> findEmail();

  Future<bool> resetPassword();

  Future<bool> kakaoSignUp({
    required bool gender,
    required String birthday,
    required String region,
  });

  Future<bool> kakaoSignIn();

  Future<bool> appleSignUp();

  Future<bool> appleSignIn();

  Future<bool> withdraw();
}
