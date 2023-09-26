abstract class UserRepositoryInterface {
  Future<bool> getAccount();

  Future<bool> register({
    required String email,
    required String password,
    required String phone,
    required String certification,
    required bool gender,
    required DateTime birthday,
    required String location,
  });

  Future<bool> emailLogin({
    required String email,
    required String password,
  });

  Future<bool> autoLogin();

  Future<bool> tokenReissue();

  Future<bool> findEmail();

  Future<bool> resetPassword();

  Future<bool> verifyUser();

  Future<bool> kakaoLogin();

  Future<bool> kakaoRegister();

  Future<bool> appleLogin();

  Future<bool> appleRegister();
}
