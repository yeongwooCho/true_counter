class TokenModel {
  late String grantType;
  late String accessToken;
  late String refreshToken;

  TokenModel._internal();

  factory TokenModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    TokenModel tokenModel = TokenModel._internal();

    tokenModel.grantType = json['grantType'] ?? '';
    tokenModel.accessToken = json['accessToken'] ?? '';
    tokenModel.refreshToken = json['refreshToken'] ?? '';

    return tokenModel;
  }
}
