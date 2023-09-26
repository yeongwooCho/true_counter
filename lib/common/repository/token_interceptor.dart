// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:true_counter/common/model/app_info.dart';
// import 'package:true_counter/common/repository/local_storage.dart';
//
// class AccessTokenInterceptor extends Interceptor {
//   @override
//   Future<dynamic> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     String? token =
//         await LocalStorage.getAccessToken(key: LocalStorageKey.accessToken);
//
//     if (token != null && token.isNotEmpty) {
//       options.headers.addAll({
//         'Authorization': 'Bearer $token',
//         'App-Version': '${AppInfo.currentVersion}',
//         'Device': Platform.isIOS ? 'ios' : 'android',
//         'Content-Type': 'application/json',
//       });
//       options.queryParameters.addAll(<String, dynamic>{
//         'access_token': 'Bearer $token',
//       });
//     }
//     return super.onRequest(options, handler);
//   }
// }
//
// class RefreshTokenInterceptor extends Interceptor {
//   @override
//   Future<dynamic> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     String? accessToken =
//         await LocalStorage.getAccessToken(key: LocalStorageKey.refreshToken);
//     String? refreshToken =
//         await LocalStorage.getAccessToken(key: LocalStorageKey.refreshToken);
//
//     if (accessToken != null &&
//         refreshToken != null &&
//         accessToken.isNotEmpty &&
//         refreshToken.isNotEmpty) {
//       options.headers.addAll({
//         'App-Version': '${AppInfo.currentVersion}',
//         'Device': Platform.isIOS ? 'ios' : 'android',
//         'Content-Type': 'application/json',
//       });
//       options.queryParameters.addAll(<String, dynamic>{
//         'access_token': 'Bearer $accessToken',
//         'refresh_token': 'Bearer $refreshToken',
//         'App-Version': '${AppInfo.currentVersion}',
//         'device': Platform.isIOS ? 'ios' : 'android'
//       });
//     }
//     return super.onRequest(options, handler);
//   }
// }
