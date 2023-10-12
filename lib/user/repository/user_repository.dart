import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/model/api_response.dart';
import 'package:true_counter/common/model/app_info.dart';
import 'package:true_counter/common/repository/base_api.dart';
import 'package:true_counter/common/repository/local_storage.dart';
import 'package:true_counter/common/repository/logging_interceptor.dart';
import 'package:true_counter/common/repository/urls.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/my_settings.dart';
import 'package:true_counter/user/model/enum/sign_up_type.dart';
import 'package:true_counter/user/model/kakao_request_model.dart';
import 'package:true_counter/user/model/token_model.dart';
import 'package:true_counter/user/model/user_model.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';
import 'package:true_counter/user/repository/kakao_auth_repository.dart';

class UserRepository extends UserRepositoryInterface {
  final _dio = BaseDio().buildDio();
  final KakaoAuthRepository _kakaoAuthRepository = KakaoAuthRepository();

  @override
  Future<bool> duplicateEmail({
    required String email,
  }) async {
    try {
      final resp = await _dio.post(
        Url.duplicateEmail,
        data: {
          "email": email,
        },
      );

      print('이메일 중복확인');
      print(resp.data);
      // // {message: 이메일 중복 여부 조회 성공, data: false}

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }
      ApiResponse<bool> responseData =
          ApiResponse<bool>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return false;
      }

      return responseData.data!;
    } catch (e) {
      debugPrint('UserRepository verifyUser Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return false;
    }
  }

  @override
  Future<bool> duplicatePhone({
    required String phone,
  }) async {
    try {
      final resp = await _dio.post(
        Url.duplicatePhone,
        data: {
          "phone": phone,
        },
      );

      print('휴대폰 중복확인');
      print(resp.data);
      // // {message: 이메일 중복 여부 조회 성공, data: false}

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }
      ApiResponse<bool> responseData =
          ApiResponse<bool>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return false;
      }

      return responseData.data!;
    } catch (e) {
      debugPrint('UserRepository verifyPhone Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return false;
    }
  }

  @override
  Future<bool> userInfo() async {
    try {
      final resp = await _dio.get(
        Url.userInfo,
        options: Options(
          headers: UserModel.getHeaders(),
        ),
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

      UserModel.fromJson(json: responseData.data!);
      return true;
    } catch (e) {
      debugPrint('UserRepository userInfo Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return false;
    }
  }

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
      debugPrint('UserRepository signUp Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return false;
    }
  }

  @override
  Future<bool> signIn({
    required String email,
    required String password,
    required SignUpType signInType,
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
          "signInType": signInType.label,
        },
      );
      // print('하이하이');
      // print(resp.data);

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
      print('tokenModel: $tokenModel');

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
      debugPrint('UserRepository signIn Error: ${e.toString()}');
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
      print('tokenModel: $tokenModel');

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
      debugPrint('UserRepository tokenReissue Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> tokenSignIn() async {
    // Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // String text = "jos10022@hanmail.netfAKFe03kfafjd3Fj39aFajdnv03idDFE39fjd";
    // String asdf = stringToBase64.encode(text);
    // print("여기여기 $asdf");
    try {
      final String? accessToken =
          await LocalStorage.getToken(key: LocalStorageKey.accessToken);
      final String? refreshToken =
          await LocalStorage.getToken(key: LocalStorageKey.refreshToken);

      if (accessToken == null ||
          accessToken.isEmpty ||
          refreshToken == null ||
          refreshToken.isEmpty) {
        return false;
      }

      final resp = await _dio.post(
        Url.tokenSignIn,
        data: {
          "accessToken": accessToken,
        },
      );
      print("tokenSignIn responseData: ${resp.data}");
      print("accessToken: $accessToken");

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }
      TokenModel.fromJson(json: {
        'grantType': 'Bearer',
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      });

      return true;
    } catch (e) {
      debugPrint('UserRepository tokenSignIn Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> kakaoSignIn() async {
    try {
      print('\n카카오 로그인 시작');
      // 카카오 로그인 - 유저 정보를 가져와서 로그인 / 회원가입에 따른 유저 처리를 한다.

      // 카카오 로그인 되어 있으면 카카오톡이 실행되지 않고 유저 정보를 KakaoRequestModel을 생성
      KakaoRequestModel kakaoRequestModel =
          await _kakaoAuthRepository.kakaoLogin();

      print("카카오 모델1: $kakaoRequestModel");

      if (kakaoRequestModel.error == null) {
        // 유저정보를 정상적으로 가져왔습니다.
        String email = kakaoRequestModel.email!;
        String password = getKakaoPassword(userInfo: email);

        final bool isSuccessSignIn = await signIn(
          email: email,
          password: password,
          signInType: SignUpType.kakao,
        );
        return isSuccessSignIn;
      } else {
        // 유저정보를 가져오지 못했습니다. 카톡을 갔다와서라도 가져와라.
        kakaoRequestModel =
            await _kakaoAuthRepository.kakaoLogin(isNewUser: true);
        print("카카오 모델2: $kakaoRequestModel");

        if (kakaoRequestModel.error == null) {
          // 유저정보를 정상적으로 가져왔다 => 로그인을 진행해라.
          String email = kakaoRequestModel.email!;
          String password = getKakaoPassword(userInfo: email);

          final bool isSuccessSignIn = await signIn(
            email: email,
            password: password,
            signInType: SignUpType.kakao,
          );
          return isSuccessSignIn;
        }
      }
      return false;
    } catch (error) {
      debugPrint('UserRepository kakaoSignIn Error: ${error.toString()}');
      return false;
    }
  }

  @override
  Future<bool> kakaoSignUp({
    required String phone,
    required bool gender,
    required String birthday,
    required String region,
  }) async {
    try {
      print('\n카카오 회원가입 시작');
      KakaoRequestModel kakaoRequestModel =
          await _kakaoAuthRepository.kakaoLogin(isNewUser: true);

      if (kakaoRequestModel.error == null) {
        // 유저정보를 정상적으로 가져왔다 => 로그인을 진행해라.
        String email = kakaoRequestModel.email!;
        String password = getKakaoPassword(userInfo: email);

        final bool isSuccessSignIn = await signUp(
          email: email,
          password: password,
          phone: phone,
          birthday: birthday,
          gender: gender,
          region: region,
          signUpType: SignUpType.kakao,
        );
        return isSuccessSignIn;
      }

      return false;
    } catch (error) {
      debugPrint('UserRepository kakaoSignUp Error: ${error.toString()}');
      return false;
    }
  }

  @override
  Future<bool> appleSignIn() {
    // TODO: implement appleSignIn
    throw UnimplementedError();
  }

  @override
  Future<bool> appleSignUp() {
    // TODO: implement appleSignUp
    throw UnimplementedError();
  }

  @override
  Future<bool> withdraw() async {
    try {
      final resp = await _dio.post(
        Url.withdraw,
        options: Options(
          headers: UserModel.getHeaders(),
        ),
      );

      print('회원탈퇴');
      print(resp.data);
      // {message: 유저 탈퇴 성공, data: true}

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }
      ApiResponse<bool> responseData =
          ApiResponse<bool>.fromJson(json: resp.data);
      print(responseData.data);

      if (responseData.data == null) {
        return false;
      }

      return responseData.data!;
    } catch (e) {
      debugPrint('UserRepository withdraw Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return false;
    }
  }

  @override
  Future<String?> findEmail({
    required String phone,
    required DateTime birthday,
  }) async {
    try {
      final resp = await _dio.post(
        Url.findEmail,
        data: {
          "phone": phone,
          "birthday": convertDateTimeToDateString(datetime: birthday),
        },
      );

      print('이메일 찾기');
      print(resp.data);
      // {message: 이메일 찾기 성공, data: {maskEmail: j***0022@hanmail.net}}

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return null;
      }
      ApiResponse<Map<String, dynamic>> responseData =
          ApiResponse<Map<String, dynamic>>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return null;
      }

      return responseData.data!['maskEmail'] as String;
    } catch (e) {
      debugPrint('UserRepository findEmail Error: ${e.toString()}');
      // TODO: 무슨 오류인지 제어해야함, 휴대폰번호가 있는지 등등
      return null;
    }
  }

  @override
  Future<bool> findPassword({
    required String email,
    required DateTime birthday,
    required String phone,
  }) async {
    try {
      final resp = await _dio.post(
        Url.findPassword,
        data: {
          "email": email,
          "phone": phone,
          "birthday": convertDateTimeToDateString(datetime: birthday),
        },
      );

      print('이메일 찾기');
      print(resp.data);
      // {message: 이메일 찾기 성공, data: {maskEmail: j***0022@hanmail.net}}

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<Map<String, dynamic>> responseData =
          ApiResponse<Map<String, dynamic>>.fromJson(json: resp.data);
      print("findPassword responseData: $responseData");

      if (responseData.data == null) {
        return false;
      }
      TokenModel tokenModel = TokenModel.fromJson(json: responseData.data!);
      print('tokenModel: $tokenModel');

      return true;
    } catch (e) {
      debugPrint('UserRepository findPassword Error: ${e.toString()}');
      return false;
    }
  }

  @override
  Future<bool> changePassword({
    required String newPassword,
  }) async {
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encodingPassword = stringToBase64.encode(newPassword);

      print(TokenModel.instance?.accessToken);

      final resp = await _dio.put(
        Url.changePassword,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${TokenModel.instance?.accessToken}",
          },
        ),
        data: {
          "newPassword": encodingPassword,
        },
      );

      print('비밀번호 변경 찾기');
      print(resp.data);

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }
      // {message: 비밀번호 변경 성공, data: 2023-10-07T10:27:34.45788}

      ApiResponse<DateTime> responseData =
          ApiResponse<DateTime>.fromJson(json: resp.data);
      print("findPassword responseData: $responseData");

      if (responseData.data == null) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('UserRepository findPassword Error: ${e.toString()}');
      return false;
    }
  }
}
