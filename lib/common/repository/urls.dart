import 'package:flutter_dotenv/flutter_dotenv.dart';

class Url {
  // final String BASE_URL = dotenv.env['BASE_URL']!;

  // final String BASE_URL =
  //     'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:8000'; // 에뮬레이터용

  String wifiIp = '172.22.32.104';

  static String baseUrl = 'http://172.22.32.104:8000';

  // user
  static String accounts = '$baseUrl/accounts/v1';
  static String register = '$baseUrl/accounts/v1/sign_up';
  static String login = '$baseUrl/accounts/v1/sign_in';
  static String autoLogin = '$baseUrl/accounts/v1/sign_in/auto';
  static String logout = '$baseUrl/accounts/v1/sign_out';
  static String findEmail = '$baseUrl/accounts/v1/find_email';
  static String resetPassword = '$baseUrl/accounts/v1/reset_password';
  static String verifyUser = '$baseUrl/accounts/v1/verify';

  // notification
  static String notification = '$baseUrl/notification/';

  // festival
  static String festival = '$baseUrl/festival/';
}
