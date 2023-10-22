import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthRepository {
  AuthorizationCredentialAppleID? appleCredential;
  // String email = '';

  Future<String?> appleLogin() async {
    try {
      // 애플 로그인 사용가능 여부
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        return null;
      }

      // 애플 로그인 요청
      appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // 응답 값 받아오기
      final credentialState = await SignInWithApple.getCredentialState(
        "${appleCredential?.userIdentifier}",
      );

      String subEmail = appleCredential?.userIdentifier?.split('.')[1] ?? '';

      // JWT 디코딩
      List<String> jwt = appleCredential?.identityToken?.split('.') ?? [];
      String payload = jwt[1];
      payload = base64.normalize(payload);

      final List<int> jsonData = base64.decode(payload);
      final userInfo = jsonDecode(utf8.decode(jsonData));
      String email = userInfo['email'] ?? subEmail;

      // appleCredential?.identityToken
      // appleCredential?.userIdentifier
      // appleCredential?.authorizationCode // 서버에 보낼 값
      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have been validated with Apple (see `Integration` section for more information on how to do this)

      return email;
    } catch (error) {
      debugPrint('AppleAuthRepository appleLogin Error: ${error.toString()}');
      return null;
    }
  }
}

// // Firebase Auth Apple
// Future<UserCredential?> signInWithApple() async {
//   try {
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );
//
//     // Create an `OAuthCredential` from the credential returned by Apple.
//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: appleCredential.identityToken,
//       accessToken: appleCredential.authorizationCode,
//     );
//
//     // Sign in the user with Firebase. If the nonce we generated earlier does
//     // not match the nonce in `appleCredential.identityToken`, sign in will fail.
//     return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//   } catch (error) {
//     debugPrint(
//         'AppleAuthRepository signInWithApple Error: ${error.toString()}');
//     return null;
//   }
// }
