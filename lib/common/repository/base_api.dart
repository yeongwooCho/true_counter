import 'dart:io';

import 'package:dio/dio.dart';
import 'package:true_counter/common/const/constants.dart';
import 'package:true_counter/common/model/app_info.dart';
import 'package:true_counter/common/repository/logging_interceptor.dart';
import 'package:true_counter/common/repository/urls.dart';

class BaseDio {
  Dio? dio;

  BaseDio()
      : dio = Dio(
          BaseOptions(
            baseUrl: Url.baseUrl,
            connectTimeout: Duration(milliseconds: Constants.connectTimeout),
            receiveTimeout: Duration(milliseconds: Constants.receiveTimeout),
            headers: {
              'App-Version': '${AppInfo.currentVersion}',
              'Device': Platform.isIOS ? 'ios' : 'android',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio?.interceptors.addAll([
      LoggingInterceptor(),
    ]);
  }

  Dio buildDio() {
    if (dio != null) {
      return dio!;
    } else {
      return Dio();
    }
  }
}
