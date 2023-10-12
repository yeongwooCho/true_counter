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
      // log('${options.method} - ${options.baseUrl}${options.path}');
      log('${options.method} - ${options.path}');
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
      log("---");
      log('--------------- Response (${_format(DateTime.now(), 'mm:ss.mmm')}) ---------------');
      // printWrapped('$response');
      log("request path: ${response.requestOptions.path}");
      log("response status code: ${response.statusCode}");
      log('response: $response');
      log('response data: ${response.data}');
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
      // log("<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
      log("<-- ${(err.response?.requestOptions != null ? ("path: ${err.response!.requestOptions.path}") : 'URL')}");
      log('type: ${err.type}');
      log('error: ${err.error}');
      log("error message: ${err.message}}");
      log('error response statusCode: ${err.response?.statusCode}');
      log('error response: ${err.response}');
      log('error response data: ${err.response != null ? err.response?.data : 'Unknown Error'}');
      log("<-- End error");
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
