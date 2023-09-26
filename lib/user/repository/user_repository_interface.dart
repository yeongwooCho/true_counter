import 'package:true_counter/user/model/enum/sign_up_type.dart';
import 'package:true_counter/user/model/token_model.dart';

abstract class UserRepositoryInterface {
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
    required bool isAutoSignIn,
  });

  Future<bool> tokenSignIn();

  Future<bool> tokenReissue();

  Future<bool> findEmail();

  Future<bool> resetPassword();

  Future<bool> verifyUser();

  Future<bool> kakaoLogin();

  Future<bool> kakaoRegister();

  Future<bool> appleLogin();

  Future<bool> appleRegister();
}
