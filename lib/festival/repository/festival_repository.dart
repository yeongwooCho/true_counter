import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/model/api_response.dart';
import 'package:true_counter/common/repository/urls.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/user/model/user_model.dart';

class FestivalRepository {
  final _dio = Dio();

  Future<List<FestivalModel>> getFestivals() async {
    print('페스티벌 데이터 받오옵니다.');
    try {
      final resp = await _dio.get(
        Url.festivals,
        options: Options(
          headers: UserModel.getHeaders(),
        ),
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return [];
      }

      ApiResponse<List<dynamic>> responseData =
          ApiResponse<List<dynamic>>.fromJson(json: resp.data);
      print("responseData: ${responseData.data}");

      if (responseData.data == null) {
        return [];
      }

      final List<FestivalModel> festivals = responseData.data!
          .map((e) => FestivalModel.fromJson(json: e))
          .toList();

      print(festivals);
      return festivals;
    } catch (e) {
      debugPrint('FestivalRepository getFestivals Error: ${e.toString()}');
      return [];
    }
  }

  Future<FestivalModel?> getFestival({
    required int id,
  }) async {
    try {
      final resp = await _dio.get(
        "${Url.festivals}/$id",
        options: Options(
          headers: UserModel.getHeaders(),
        ),
      );

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

      final FestivalModel festivalModel =
          FestivalModel.fromJson(json: responseData.data!);

      return festivalModel;
    } catch (e) {
      debugPrint('FestivalRepository getFestival Error: ${e.toString()}');
      return null;
    }
  }

  Future<bool> createFestival({
    required String title, //: "응우&기중 시가파티 참석자 모집",
    required String applicant, //: "응우컴퍼니",
    required String applicantPhone, //: "01022223333",
    required String message, //: "응우와 시가파티",
    required double latitude, //: 12312.3213,
    required double longitude, //: 134432.234,
    required double radius, //: 0.5,
    required String address, //: "응우 해피 하우스",
    required String region, //: "부산 금정구",
    required DateTime startAt, //: "2023-10-03T22:39:00",
    required DateTime endAt, //: "2023-10-03T22:39:00",
    required bool isValid, //: true
  }) async {
    try {
      final resp = await _dio.post(
        Url.festivals,
        options: Options(
          headers: UserModel.getHeaders(),
        ),
        data: {
          "title": title,
          "applicant": applicant,
          "applicantPhone": applicantPhone,
          "message": message,
          "latitude": latitude,
          "longitude": longitude,
          "radius": radius,
          "address": address,
          "region": region,
          "startAt": startAt.toIso8601String().split('.').first,
          "endAt": endAt.toIso8601String().split('.').first,
          "isValid": isValid,
        },
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<String> responseData =
          ApiResponse<String>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('FestivalRepository createFestival Error: ${e.toString()}');
      return false;
    }
  }

  Future<ChatModel?> createChat({
    required int festivalId,
    int? parentChatId,
    required String content,
  }) async {
    try {
      final resp = await _dio.post(
        Url.festivalChats,
        options: Options(
          headers: UserModel.getHeaders(),
        ),
        data: {
          "festivalId": festivalId,
          "parentChatId": parentChatId,
          "content": content,
        },
      );

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

      final ChatModel chatModel = ChatModel.fromJson(json: responseData.data!);
      return chatModel;
    } catch (e) {
      debugPrint('FestivalRepository getFestival Error: ${e.toString()}');
      return null;
    }
  }

  Future<bool> participateFestival({
    required int festivalId,
  }) async {
    try {
      final resp = await _dio.post(
        "${Url.festivals}/$festivalId/participate",
        options: Options(
          headers: UserModel.getHeaders(),
        ),
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      ApiResponse<int> responseData =
          ApiResponse<int>.fromJson(json: resp.data);

      if (responseData.data == null || responseData.data != festivalId) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('FestivalRepository participateFestival Error: ${e.toString()}');
      return false;
    }
  }
}
