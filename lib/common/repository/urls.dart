import 'package:flutter_dotenv/flutter_dotenv.dart';

class Url {
  static String baseUrl = dotenv.env['BASE_URL']!;

  // user
  static String userInfo = "$baseUrl/members/my-info";
  static String signUp = "$baseUrl/auth/sign-up";
  static String signIn = "$baseUrl/auth/sign-in";
  static String tokenSignIn = "$baseUrl/auth/test";
  static String reissue = "$baseUrl/auth/reissue";
  static String findEmail = "$baseUrl/auth/findEmail";
  static String findPassword = "$baseUrl/auth/findPassword";

  // notification
  // Create, Read
  static String noticeBoard = "$baseUrl/notice-board";

  // Update, Delete
  // static String noticeBoard = "$baseUrl/notice-board/1";

  // festival
  // Create, Retrieve list
  static String festivals = "$baseUrl/festivals";

  // Retrieve once
  // static String festival = "$baseUrl/festivals/4";

  // festival status
  static String festivalStatus = "$baseUrl/festivals?status=PAST";

  // festival participate
  // static String festivalParticipate = "$baseUrl/festivals/12/participate";

  // festival chat create
  static String festivalChats = "$baseUrl/chats";
}
