import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
}
