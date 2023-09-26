import 'dart:io';

import 'package:dio/dio.dart';
import 'package:true_counter/common/model/app_info.dart';
import 'package:true_counter/common/repository/urls.dart';

class BaseApi {
  Dio? dio;
  static int connectTimeout = 10000; // 10 seconds
  static int receiveTimeout = 10000; // 10 seconds

  BaseApi()
      : dio = Dio(
          BaseOptions(
            baseUrl: Url.baseUrl,
            connectTimeout: Duration(milliseconds: connectTimeout),
            receiveTimeout: Duration(milliseconds: receiveTimeout),
            headers: {
              'App-Version': '${AppInfo.currentVersion}',
              'Device': Platform.isIOS ? 'ios' : 'android',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {}
}
