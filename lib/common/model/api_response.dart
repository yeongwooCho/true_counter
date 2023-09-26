class ApiResponse<T> {
  String? message;
  T? data;

  ApiResponse({
    required this.message,
    required this.data,
  });

  ApiResponse.fromJson({
    required Map<String, dynamic> json,
  })  : message = json['message'],
        data = json['data'];

  @override
  String toString() {
    return 'ApiResponse<$T> = {message: $message, data: $data}';
  }
}
