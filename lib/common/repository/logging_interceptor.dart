import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:true_counter/common/const/constants.dart';

class LoggingInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (Constants.loggingInterceptorEnabled) {
      log("---");
      log(DateTime.now().toString());
      log('--------------- Request (${_format(DateTime.now(), 'mm:ss.mmm')}) ---------------');
      log('${options.method} - ${options.baseUrl}${options.path}');
      log('Headers ${options.headers}');
      log('Content-Type: ${options.contentType}');
      if (options.data is FormData) {
        log('- file ${(options.data as FormData).files.toString()}');
      } else {
        log('- ${options.data}');
      }
      log('Query parameters ${options.queryParameters}');
      log('---------------------------------------');
      log("---");
    }
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (Constants.loggingInterceptorEnabled) {
      print('123123');
      print(response.requestOptions);
      print("response.statusMessage: ${response.statusMessage}");
      print("response.statusCode: ${response.statusCode}"); // 200
      print(response.realUri.path);
      print(response.redirects);
      print(response.hashCode);
      log("---");
      log('--------------- Response (${_format(DateTime.now(), 'mm:ss.mmm')}) ---------------');
      printWrapped('$response');
      log('---------------------------------------');
      log("---");
    }
    return handler.next(response);
  }

  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (Constants.loggingInterceptorEnabled) {
      log("---");
      log('--------------- Error (${_format(DateTime.now(), 'mm:ss.mmm')}) ---------------');
      log('type${err.type}');
      log('error${err.error}');
      log('response${err.response}');
      print(123123);
      print(err.requestOptions.responseDecoder);

      print("err.response?.extra: ${err.response?.extra}");
      print("err.response?.data: ${err.response?.data}");

      print("err.requestOptions.receiveDataWhenStatusError: ${err.requestOptions.receiveDataWhenStatusError}");
      print("err.response?.statusCode: ${err.response?.statusCode}");
      print("err.response?.statusMessage: ${err.response?.statusMessage}");
      print(123123);
      print(err.message);
      print(err.error);
      print(
          "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
      print("${err.response != null ? err.response?.data : 'Unknown Error'}");
      print("<-- End error");
      print(123123);
      log('---------------------------------------');
      log("---");
    }
    return handler.next(err);
  }

  static String _format(DateTime dateTime, String formatPattern) {
    DateFormat dateFormat = DateFormat(formatPattern);
    return dateFormat.format(dateTime);
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
