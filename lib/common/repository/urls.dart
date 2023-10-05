import 'package:flutter_dotenv/flutter_dotenv.dart';

class Url {
  static String baseUrl = dotenv.env['BASE_URL']!;

  // user
  static String userInfo = "$baseUrl/members";
  static String signUp = "$baseUrl/auth/sign-up";
  static String signIn = "$baseUrl/auth/sign-in";
  static String tokenSignIn = "$baseUrl/auth/test";
  static String reissue = "$baseUrl/auth/reissue";

  // notification
  static String noticeBoard = "$baseUrl/notice-board";

// // user
// static String accounts = '$baseUrl/accounts/v1';
// static String register = '$baseUrl/accounts/v1/sign_up';
//
// static String emailLogin = '$baseUrl/accounts/v1/sign_in';
// static String kakaoLogin = '$baseUrl/accounts/v1/sign_in';
// static String appleLogin = '$baseUrl/accounts/v1/sign_in';
//
// static String autoLogin = '$baseUrl/accounts/v1/sign_in/auto';
// static String logout = '$baseUrl/accounts/v1/sign_out';
// static String findEmail = '$baseUrl/accounts/v1/find_email';
// static String resetPassword = '$baseUrl/accounts/v1/reset_password';
// static String verifyUser = '$baseUrl/accounts/v1/verify';
//
// // notification
// static String notification = '$baseUrl/notification/';
//
// // festival
// static String festival = '$baseUrl/festival/';
}
