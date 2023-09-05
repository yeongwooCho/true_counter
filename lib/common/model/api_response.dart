class ApiResponse<T> {
  late int code;
  String? message;
  T? data;
  Map<String, T>? dataDict;

  ApiResponse();

  ApiResponse.fromJson({
    required Map<String, dynamic> json,
  })  : code = json['code'],
        message = json['message'],
        data = json['data'],
        dataDict = json['dataDict'];

  @override
  String toString() {
    return 'ApiResponse<$T> = { code: $code, message: $message, data: $data, dataDict: $dataDict }';
  }
}
