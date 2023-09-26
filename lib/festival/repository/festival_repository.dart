import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/model/api_response.dart';
import 'package:true_counter/common/repository/urls.dart';
import 'package:true_counter/festival/model/festival_model.dart';

class FestivalRepository {
  final _dio = Dio();

  Future<List<FestivalModel>> getFestivals() async {
    // final resp = await _dio.get(Url.festival);
    //
    // if (resp.statusCode == null ||
    //     resp.statusCode! < 200 ||
    //     resp.statusCode! > 400) {
    //   return [];
    // }

    final dummyJsonData = await rootBundle.loadString('asset/json/data.json');

    final dummyData = jsonDecode(dummyJsonData);
    // print('여기여기');
    // print(dummyData);
    // print(dummyData.runtimeType);

    try {
      // ApiResponse<List<FestivalModel>> festivals =
      //     ApiResponse<List<FestivalModel>>.fromJson(json: dummyData);
      ApiResponse<List<dynamic>> festivals =
          ApiResponse<List<dynamic>>.fromJson(json: dummyData);
      if (festivals.data == null || festivals.data!.isEmpty) {
        return [];
      }

      return festivals.data!
          .map((e) => FestivalModel.fromJson(json: e))
          .toList();
    } catch (e) {
      debugPrint('FestivalRepository Error: ${e.toString()}');
      return [];
    }
  }
}
