import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/model/api_response.dart';
import 'package:true_counter/common/repository/local_storage.dart';
import 'package:true_counter/common/repository/urls.dart';
import 'package:true_counter/user/model/kakao_request_model.dart';
import 'package:true_counter/user/model/token_model.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';
import 'package:true_counter/user/util/kakao_auth.dart';

class UserRepository extends UserRepositoryInterface {
  final _dio = Dio();
  final KakaoAuth _kakaoAuth = KakaoAuth();

  @override
  Future<bool> register({
    required String email,
    required String password,
    required String phone,
    required String certification,
    required bool gender,
    required DateTime birthday,
    required String location,
  }) async {
    try {
      final resp = await _dio.post(
        Url.register,
        data: {
          "email": email,
          "password": password,
          "phone": phone,
          "certification": certification,
          "gender": gender,
          "birthday": birthday,
          "location": location,
        },
      );
      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<TokenModel> tokenModel = ApiResponse<TokenModel>.fromJson(
        json: resp.data,
      );

      if (tokenModel.data == null) {
        return false;
      }

      await LocalStorage.setAccessToken(
        key: LocalStorageKey.accessToken,
        value: resp.data['refreshToken'],
      );
      await LocalStorage.setAccessToken(
        key: LocalStorageKey.refreshToken,
        value: resp.data['accessToken'],
      );

      return true;
    } catch (e) {
      debugPrint('UserRepository Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> emailLogin({
    required String email,
    required String password,
  }) async {
    String rawString = '$email:$password';

    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String token = stringToBase64.encode(rawString);

    try {
      final resp = await _dio.post(
        Url.emailLogin,
        options: Options(
          headers: {
            'authorization': 'Basic $token',
          },
        ),
      );
      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<TokenModel> tokenModel = ApiResponse<TokenModel>.fromJson(
        json: resp.data,
      );

      if (tokenModel.data == null) {
        return false;
      }

      await LocalStorage.setAccessToken(
        key: LocalStorageKey.accessToken,
        value: resp.data['refreshToken'],
      );
      await LocalStorage.setAccessToken(
        key: LocalStorageKey.refreshToken,
        value: resp.data['accessToken'],
      );

      return true;
    } catch (e) {
      debugPrint('UserRepository Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> autoLogin() async {
    try {
      final accessToken =
          LocalStorage.getToken(key: LocalStorageKey.accessToken);
      final resp = await _dio.post(
        Url.autoLogin,
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('UserRepository Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> tokenReissue() async {
    try {
      final accessToken =
          LocalStorage.getToken(key: LocalStorageKey.accessToken);
      final refreshToken =
          LocalStorage.getToken(key: LocalStorageKey.refreshToken);

      final resp = await _dio.post(
        Url.autoLogin,
        options: Options(
          headers: {
            'authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        },
      );
      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('UserRepository Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> appleLogin() {
    // TODO: implement appleLogin
    throw UnimplementedError();
  }

  @override
  Future<bool> appleRegister() {
    // TODO: implement appleRegister
    throw UnimplementedError();
  }

  @override
  Future<bool> findEmail() {
    // TODO: implement findEmail
    throw UnimplementedError();
  }

  @override
  Future<bool> getAccount() {
    // TODO: implement getAccount
    throw UnimplementedError();
  }

  @override
  Future<bool> kakaoRegister() {
    // TODO: implement kakaoRegister
    throw UnimplementedError();
  }

  @override
  Future<bool> resetPassword() {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyUser() {
    // TODO: implement verifyUser
    throw UnimplementedError();
  }

  @override
  Future<bool> kakaoLogin() async {
    bool isNewUser = false;
    // 카카오 로그인 - 유저 정보를 가져와서 로그인 / 회원가입에 따른 유저 처리를 한다.

    // 카카오 로그인 되어 있으면 카카오톡이 실행되지 않고 유저 정보를 KakaoRequestModel을 생성
    KakaoRequestModel? kakaoRequestModel = await _kakaoAuth.kakaoLogin();

    // 카카오 유저 정보를 불러오지 못하면 새로운 유저 이므로 카카오톡을 실행해 회원가입을 진행한다.
    if (kakaoRequestModel == null) {
      kakaoRequestModel = await _kakaoAuth.kakaoLogin(isNewUser: true);
      isNewUser = true;
    }

    // try {
    //   // String url = URL_SNS_LOGIN;
    //   // if (isNewUser == true) {
    //   //   url = URL_SMS_SIGN_UP;
    //   // }
    //
    //   var resp = await _dio.get(
    //     TEST_USER,
    //     // data: {
    //     //   // 'email': kakaoRequestModel.email,
    //     //   // 'login_type': kakaoRequestModel.loginType,
    //     //   // 'kakao_uid': kakaoRequestModel.uid,
    //     //   // 'kakao_token': kakaoRequestModel.token,
    //     //   // 'app_version': AppInfo.currentVersion,
    //     //   // 'device': Platform.isIOS ? 'ios' : 'android',
    //     // },
    //   );
    //   print('여기여기2');
    //   print(resp);
    //   // ApiResponse<UserModel> resp = await _dio.post(
    //   //   url,
    //   //   data: {
    //   //     'email': kakaoRequestModel.email,
    //   //     'login_type': kakaoRequestModel.loginType,
    //   //     'kakao_uid': kakaoRequestModel.uid,
    //   //     'kakao_token': kakaoRequestModel.token,
    //   //     'app_version': AppInfo.currentVersion,
    //   //     'device': Platform.isIOS ? 'ios' : 'android',
    //   //   },
    //   // ) as ApiResponse<UserModel>;
    //   // print('여기여기2');
    //   // print(kakaoRequestModel);
    //
    //   // return resp;
    //   return null;
    // } catch (e) {
    //   print('error 발생 ${e.toString()}');
    // }

    return true;
  }
}
