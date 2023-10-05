class TokenModel {
  late String grantType;
  late String accessToken;
  late String refreshToken;

  static TokenModel? instance; // 현재 유저가 있는지 여부

  TokenModel._internal();

  factory TokenModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    TokenModel tokenModel = TokenModel._internal();

    tokenModel.grantType = json['grantType'] ?? '';
    tokenModel.accessToken = json['accessToken'] ?? '';
    tokenModel.refreshToken = json['refreshToken'] ?? '';

    instance = tokenModel;
    print("토큰 모델 만듬 tokenModel: $tokenModel");

    return tokenModel;
  }

  @override
  String toString() {
    return 'TokenModel ('
        'grantType: $grantType, '
        'accessToken: $accessToken, '
        'refreshToken: $refreshToken, '
        ')';
  }
}
