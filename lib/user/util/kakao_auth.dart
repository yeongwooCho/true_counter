import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter/services.dart';
import 'package:true_counter/user/model/kakao_request_model.dart';

class KakaoAuth {
  kakao.OAuthToken? kakaoToken;
  kakao.User? kakaoUser;

  Future<KakaoRequestModel?> kakaoLogin({
    bool isNewUser = false,
  }) async {
    // 새로운 유저의 경우만 카카오톡 접근
    if (isNewUser) {
      try {
        kakaoToken = await kakao.UserApi.instance.loginWithKakaoTalk();
      } catch (e) {
        if (e is PlatformException) {
          kakaoToken = await kakao.UserApi.instance.loginWithKakaoAccount();
        }
      }
    }

    try {
      kakao.User kakaoUser1 = await kakao.UserApi.instance.me();
      print(kakaoToken);
      // {
      //   access_token: MzZzDSJbrQ9lqDYKUhwl2chcaLAdA5TR-zU7HuDOCj10aAAAAYpgWl0c,
      //   expires_at: 2023-09-05T10:20:48.462,
      //   refresh_token: yEcI0vsP5md4q1RRe92JrOV_PbAIv-BDHyPacCCGCj10aAAAAYpgWl0a,
      //   refresh_token_expires_at: 2023-11-03T22:20:48.462,
      //   scopes: [age_range, account_email, gender]
      // }

      print(kakaoUser1.id); // 3004783671
      print(kakaoUser1.connectedAt); // 2023-09-04 13:20:49.000Z
      print(kakaoUser1.groupUserToken); // null
      print(kakaoUser1.hasSignedUp); // null
      print(kakaoUser1.kakaoAccount);
      // {
      //   email_needs_agreement: false,
      //   is_email_valid: true,
      //   is_email_verified: true,
      //   email: jyy0223@naver.com,
      //   age_range_needs_agreement: false,
      //   age_range: 20~29,
      //   gender_needs_agreement: false,
      //   gender: male
      // }

      kakaoUser = await kakao.UserApi.instance.me();

      // kakaoToken.accessToken
      // email
      //
      // users_api
      //     .kakaoLogin('${kakaoUser.id}', kakaoToken!.accessToken,
      //     kakaoUser.kakaoAccount?.email ?? '',
      //     newUser: newUser)
      //     .then((apiResponse) {
      //   loginResult(apiResponse, LoginType.kakao);
      // });

      // TODO: 백엔드로 요청을 보내서 계정이 있는 사용자인지 아닌지를 체크한다.
      // 있으면 계정정보를 넘겨준다.
      // 없으면 isNewUser 를 true 로 변경한다.

      return KakaoRequestModel(
        uid: kakaoUser?.id,
        token: kakaoToken?.accessToken,
        email: kakaoUser?.kakaoAccount?.email,
      );
    } catch (e) {
      if (e is PlatformException) {
        // SimpleConfirmDialog(context, '카카오톡이 설치되어있지 않습니다.', '설치 후에 이용해주세요.').show();
      }
      print('카카오톡으로 로그인 실패 ${e.toString()}');
      // return;
    }
    return null;
  }
}
