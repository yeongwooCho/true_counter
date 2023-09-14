import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageKey {
  static String email = 'email';
  static String token = 'token';
  static String pushToken = 'pushToken';
}

class LocalStorage {
  static const FlutterSecureStorage _instance = FlutterSecureStorage();

  // splash에서 init
  static Future<void> init() async {
    // local storage 초기화
    // instance.erase();
    // return;
  }

  // 읽기
  static Future<String> read({
    required String key,
  }) async {
    return await _instance.read(key: key) ?? '';
  }

  // 저장
  static Future<void> write({
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
}
