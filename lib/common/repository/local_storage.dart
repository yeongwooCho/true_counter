import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageKey {
  static String accessToken = 'access_token';
  static String refreshToken = 'refresh_token';
}

class LocalStorage {
  static const FlutterSecureStorage _instance = FlutterSecureStorage();

  // 읽기
  static Future<String?> getAccessToken({
    required String key,
  }) async {
    return await _instance.read(key: key);
  }

  // 저장
  static Future<void> setAccessToken({
    required String key,
    required String value,
  }) async {
    await _instance.write(
      key: key,
      value: value,
      iOptions: const IOSOptions(
        accessibility: KeychainAccessibility.passcode,
      ),
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  // 전부 삭제
  static Future<void> clearAll() async {
    await _instance.deleteAll();
  }

  // 일부 삭제
  static Future<void> clear({
    required String key,
  }) async {
    await _instance.delete(key: key);
  }

  Future<bool> hasAuthenticated() async {
    String? accessToken =
        await getAccessToken(key: LocalStorageKey.accessToken);

    return accessToken != null && accessToken.isNotEmpty;
  }
}
