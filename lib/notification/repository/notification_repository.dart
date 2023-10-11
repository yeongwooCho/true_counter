import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/model/api_response.dart';
import 'package:true_counter/common/repository/base_api.dart';
import 'package:true_counter/common/repository/urls.dart';
import 'package:true_counter/notification/model/notification_model.dart';
import 'package:true_counter/user/model/user_model.dart';

class NotificationRepository {
  final _dio = BaseDio().buildDio();

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final resp = await _dio.get(
        Url.noticeBoard,
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

      if (responseData.data == null) {
        return [];
      }

      final notifications = responseData.data!
          .map<NotificationModel>((e) => NotificationModel.fromJson(json: e))
          .toList();

      return notifications;
    } catch (e) {
      debugPrint('NotificationRepository Error: ${e.toString()}');
      return [];
    }
  }

  Future<int?> createNotification({
    required String title,
    required String content,
  }) async {
    try {
      final resp = await _dio.post(
        Url.noticeBoard,
        options: Options(
          headers: UserModel.getHeaders(),
        ),
        data: {
          "title": title,
          "content": content,
        },
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return null;
      }

      print('공지사항 등록');
      print(resp.data);
      // {message: 공지사항 생성, data: 5}

      ApiResponse<int> responseData =
          ApiResponse<int>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return null;
      }

      return responseData.data!;
    } catch (e) {
      debugPrint('NotificationRepository Error: ${e.toString()}');
      return null;
    }
  }

  Future<bool> deleteNotification({
    required int id,
    required String title,
    required String content,
  }) async {
    try {
      final resp = await _dio.delete(
        "${Url.noticeBoard}/$id",
        options: Options(
          headers: UserModel.getHeaders(),
        ),
        data: {
          "title": title,
          "content": content,
        },
      );

      if (resp.statusCode == null ||
          resp.statusCode! < 200 ||
          resp.statusCode! > 400) {
        return false;
      }

      print('공지사항 등록');
      print(resp.data);
      // {message: 공지사항 삭제, data: } : String

      ApiResponse<String> responseData =
          ApiResponse<String>.fromJson(json: resp.data);

      if (responseData.data == null) {
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('NotificationRepository Error: ${e.toString()}');
      return false;
    }
  }
}
