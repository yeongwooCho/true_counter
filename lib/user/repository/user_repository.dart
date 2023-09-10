import 'package:dio/dio.dart';
import 'package:true_counter/user/model/kakao_request_model.dart';
import 'package:true_counter/user/util/kakao_auth.dart';

class UserRepository {
  final _dio = Dio();
  final KakaoAuth _kakaoAuth = KakaoAuth();

  Future<void> kakaoLogin() async {
    bool isNewUser = false;
    // 카카오 로그인 - 유저 정보를 가져와서 로그인 / 회원가입에 따른 유저 처리를 한다.

    // 카카오 로그인 되어 있으면 카카오톡이 실행되지 않고 유저 정보를 KakaoRequestModel을 생성
    KakaoRequestModel? kakaoRequestModel = await _kakaoAuth.kakaoLogin();

    // 카카오 유저 정보를 불러오지 못하면 새로운 유저 이므로 카카오톡을 실행해 회원가입을 진행한다.
    if (kakaoRequestModel == null) {
      kakaoRequestModel = await _kakaoAuth.kakaoLogin(isNewUser: true);
      isNewUser = true;
    }

    // try {
    //   // String url = URL_SNS_LOGIN;
    //   // if (isNewUser == true) {
    //   //   url = URL_SMS_SIGN_UP;
    //   // }
    //
    //   var resp = await _dio.get(
    //     TEST_USER,
    //     // data: {
    //     //   // 'email': kakaoRequestModel.email,
    //     //   // 'login_type': kakaoRequestModel.loginType,
    //     //   // 'kakao_uid': kakaoRequestModel.uid,
    //     //   // 'kakao_token': kakaoRequestModel.token,
    //     //   // 'app_version': AppInfo.currentVersion,
    //     //   // 'device': Platform.isIOS ? 'ios' : 'android',
    //     // },
    //   );
    //   print('여기여기2');
    //   print(resp);
    //   // ApiResponse<UserModel> resp = await _dio.post(
    //   //   url,
    //   //   data: {
    //   //     'email': kakaoRequestModel.email,
    //   //     'login_type': kakaoRequestModel.loginType,
    //   //     'kakao_uid': kakaoRequestModel.uid,
    //   //     'kakao_token': kakaoRequestModel.token,
    //   //     'app_version': AppInfo.currentVersion,
    //   //     'device': Platform.isIOS ? 'ios' : 'android',
    //   //   },
    //   // ) as ApiResponse<UserModel>;
    //   // print('여기여기2');
    //   // print(kakaoRequestModel);
    //
    //   // return resp;
    //   return null;
    // } catch (e) {
    //   print('error 발생 ${e.toString()}');
    // }

    return null;
  }
}
