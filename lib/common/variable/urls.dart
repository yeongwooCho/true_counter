import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

// final String BASE_URL = dotenv.env['BASE_URL']!;

// final String BASE_URL =
//     'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:8000'; // 에뮬레이터용

String WIFI_IP = '172.22.32.104';
final String BASE_URL = 'http://$WIFI_IP:8000'; // 실기기용: runserver 0.0.0.0:8000

// accounts
String URL_ACCOUNTS = BASE_URL + '/accounts/v1';
String URL_REGISTER = BASE_URL + '/accounts/v1/sign_up';
String URL_LOGIN = BASE_URL + '/accounts/v1/sign_in';
String URL_LOGIN_AUTO = BASE_URL + '/accounts/v1/sign_in/auto';
String URL_LOGOUT = BASE_URL + '/accounts/v1/sign_out';
String URL_FIND_EMAIL = BASE_URL + '/accounts/v1/find_email';
String URL_RESET_PASSWORD = BASE_URL + '/accounts/v1/reset_password';
String URL_VERIFY_USER = BASE_URL + '/accounts/v1/verify';



