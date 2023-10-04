import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter/services.dart';
import 'package:true_counter/user/model/kakao_request_model.dart';

class KakaoAuthRepository {
  kakao.OAuthToken? kakaoToken;
  kakao.User? kakaoUser;

  Future<KakaoRequestModel> kakaoLogin({
    bool isNewUser = false,
  }) async {
    // 새로운 유저의 경우만 카카오톡 접근
    if (isNewUser) {
      // 카카오 로그인 구현 예제

      // 카카오톡 실행 가능 여부 확인
      // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
      if (await kakao.isKakaoTalkInstalled()) {
        try {
          kakaoToken = await kakao.UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return KakaoRequestModel(error: '카카오계정으로 로그인 실패: $error');
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            kakaoToken = await kakao.UserApi.instance.loginWithKakaoAccount();
          } catch (error) {
            return KakaoRequestModel(error: '카카오계정으로 로그인 실패: $error');
          }
        }
      } else {
        try {
          kakaoToken = await kakao.UserApi.instance.loginWithKakaoAccount();
        } catch (error) {
          return KakaoRequestModel(error: '카카오계정으로 로그인 실패: $error');
        }
      }
    }

    try {
      kakaoUser = await kakao.UserApi.instance.me();

      if (kakaoUser == null ||
          kakaoToken == null ||
          kakaoUser!.kakaoAccount == null) {
        return KakaoRequestModel(error: '카카오에서 유저정보를 들고오지 못했습니다.');
      }

      // print(kakaoToken);
      // // {
      // //   access_token: MzZzDSJbrQ9lqDYKUhwl2chcaLAdA5TR-zU7HuDOCj10aAAAAYpgWl0c,
      // //   expires_at: 2023-09-05T10:20:48.462,
      // //   refresh_token: yEcI0vsP5md4q1RRe92JrOV_PbAIv-BDHyPacCCGCj10aAAAAYpgWl0a,
      // //   refresh_token_expires_at: 2023-11-03T22:20:48.462,
      // //   scopes: [age_range, account_email, gender]
      // // }

      // print(kakaoUser!.kakaoAccount);
      // // {
      // //   email_needs_agreement: false,
      // //   is_email_valid: true,
      // //   is_email_verified: true,
      // //   email: jyy0223@naver.com,
      // //   age_range_needs_agreement: false,
      // //   age_range: 20~29,
      // //   gender_needs_agreement: false,
      // //   gender: male
      // // }

      return KakaoRequestModel(
        uid: kakaoUser?.id,
        token: kakaoToken?.accessToken,
        email: kakaoUser?.kakaoAccount?.email,
      );
    } catch (error) {
      return KakaoRequestModel(error: '카카오톡이 설치되어 있지 않습니다: $error');
    }
  }
}
