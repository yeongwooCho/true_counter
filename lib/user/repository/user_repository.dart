import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/model/api_response.dart';
import 'package:true_counter/common/model/app_info.dart';
import 'package:true_counter/common/repository/local_storage.dart';
import 'package:true_counter/common/repository/urls.dart';
import 'package:true_counter/user/model/enum/sign_up_type.dart';
import 'package:true_counter/user/model/kakao_request_model.dart';
import 'package:true_counter/user/model/token_model.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';
import 'package:true_counter/user/util/kakao_auth.dart';

class UserRepository extends UserRepositoryInterface {
  final _dio = Dio();
  final KakaoAuth _kakaoAuth = KakaoAuth();

  @override
  Future<bool> signUp({
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required bool gender,
    required String region,
    required SignUpType signUpType,
  }) async {
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encodingPassword = stringToBase64.encode(password);

      final resp = await _dio.post(
        Url.signUp,
        data: {
          "email": email,
          "password": encodingPassword,
          "phone": phone,
          "birthday": birthday,
          "gender": gender,
          "region": region,
          "appVersion": AppInfo.currentVersion,
          "signupType": signUpType.label,
        },
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<Map<String, dynamic>> responseData =
          ApiResponse<Map<String, dynamic>>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return false;
      }

      TokenModel tokenModel = TokenModel.fromJson(json: responseData.data!);
      await LocalStorage.clearAll();
      await LocalStorage.setAccessToken(
        key: LocalStorageKey.accessToken,
        value: tokenModel.accessToken,
      );
      await LocalStorage.setAccessToken(
        key: LocalStorageKey.refreshToken,
        value: tokenModel.refreshToken,
      );

      return true;
    } catch (e) {
      debugPrint('UserRepository Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return false;
    }
  }

  @override
  Future<bool> signIn({
    required String email,
    required String password,
    bool isAutoSignIn = true,
  }) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodingPassword = stringToBase64.encode(password);

    try {
      final resp = await _dio.post(
        Url.signIn,
        data: {
          "email": email,
          "password": encodingPassword,
          "autoSignIn": isAutoSignIn,
        },
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<Map<String, dynamic>> responseData =
          ApiResponse<Map<String, dynamic>>.fromJson(json: resp.data);
      print("signIn responseData: $responseData");

      if (responseData.data == null) {
        return false;
      }

      TokenModel tokenModel = TokenModel.fromJson(json: responseData.data!);

      if (isAutoSignIn) {
        await LocalStorage.clearAll();
        await LocalStorage.setAccessToken(
          key: LocalStorageKey.accessToken,
          value: tokenModel.accessToken,
        );
        await LocalStorage.setAccessToken(
          key: LocalStorageKey.refreshToken,
          value: tokenModel.refreshToken,
        );
      } else {
        tempAccessToken = tokenModel.accessToken;
        tempRefreshToken = tokenModel.refreshToken;
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
      final String? accessToken =
          await LocalStorage.getToken(key: LocalStorageKey.accessToken);
      final String? refreshToken =
          await LocalStorage.getToken(key: LocalStorageKey.refreshToken);

      if (accessToken == null ||
          refreshToken == null ||
          accessToken.isEmpty ||
          refreshToken.isEmpty) {
        return false;
      }

      final resp = await _dio.post(
        Url.reissue,
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

      ApiResponse<Map<String, dynamic>> responseData =
          ApiResponse<Map<String, dynamic>>.fromJson(json: resp.data);
      print("tokenReissue responseData: $responseData");

      if (responseData.data == null) {
        return false;
      }
      TokenModel tokenModel = TokenModel.fromJson(json: responseData.data!);
      await LocalStorage.clearAll();
      await LocalStorage.setAccessToken(
        key: LocalStorageKey.accessToken,
        value: tokenModel.accessToken,
      );
      await LocalStorage.setAccessToken(
        key: LocalStorageKey.refreshToken,
        value: tokenModel.refreshToken,
      );

      return true;
    } catch (e) {
      debugPrint('UserRepository Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> tokenSignIn() async {
    try {
      final String? accessToken =
          await LocalStorage.getToken(key: LocalStorageKey.accessToken);

      if (accessToken == null || accessToken.isEmpty) {
        return false;
      }

      final resp = await _dio.post(
        Url.tokenSignIn,
        data: {
          "accessToken": accessToken,
        },
      );
      print("tokenSignIn responseData: ${resp.data}");

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
