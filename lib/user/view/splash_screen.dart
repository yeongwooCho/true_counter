import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';
import 'package:true_counter/notification/provider/notification_provider.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserRepositoryInterface _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();

    initSplash();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 1.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TRUE COUNTER',
                  style: appNameTextStyle.copyWith(
                    color: PRIMARY_COLOR,
                  ),
                ),
                const SizedBox(height: 36.0),
                Text(
                  '실시간 참여자 수',
                  style: headTitleTextStyle.copyWith(
                    color: SECONDARY_COLOR,
                  ),
                ),
                Text(
                  '집계 시스템',
                  style: headTitleTextStyle.copyWith(
                    color: SECONDARY_COLOR,
                  ),
                ),
              ],
            ),
            Text(
              '당신의 참여가\n역사가 됩니다.',
              style: bodyTitleBoldTextStyle.copyWith(
                color: DARK_GREY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initSplash() async {
    bool isAutoLogin = await autoLogin();
    if (isAutoLogin) {
      await getUserInfo();
    }

    await getSplashData(); // 공지, 페스티벌 데이터 등 공개된 데이터

    String nextRoute = RouteNames.onBoarding;
    if (isAutoLogin) {
      nextRoute = RouteNames.root;
    }
    await Future.delayed(const Duration(seconds: 1));

    Navigator.of(context).popAndPushNamed(nextRoute);
  }

  Future<bool> getSplashData() async {
    try {
      final notificationProvider = context.read<NotificationProvider>();
      notificationProvider.getNotifications();

      final festivalProvider = context.read<FestivalProvider>();
      festivalProvider.getFestivals();
    } catch (error) {
      debugPrint('Splash getSplashData Error: ${error.toString()}');
      return false;
    }
    return true;
  }

  Future<bool> getUserInfo() async {
    try {
      final isSuccessGetUserInfo = await _userRepository.userInfo();
      debugPrint("유저정보 가져오기 성공?: $isSuccessGetUserInfo");
      return isSuccessGetUserInfo;
    } catch (error) {
      debugPrint('Splash getUserInfo Error: ${error.toString()}');
      return false;
    }
  }

  Future<bool> autoLogin() async {
    // 토큰 로그인 시도
    final bool isTokenSignIn = await _userRepository.tokenSignIn();
    print('로그인 시도 : $isTokenSignIn');

    // 토큰 로그인 실패
    if (!isTokenSignIn) {
      // refresh token 재발급
      final bool isTokenReissue = await _userRepository.tokenReissue();
      print('토큰 재발급하기 : $isTokenReissue');

      // refresh token 재발급 성공
      if (isTokenReissue) {
        bool isSuccess = await _userRepository.tokenSignIn();
        print('토큰 재로그인 시도 : $isTokenSignIn');
        return isSuccess;
      }
    }

    return isTokenSignIn;
  }
}

// import 'package:custom_clothes/common/layout/default_layout.dart';
// import 'package:flutter/material.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     checkToken();
//   }
//
//   void checkToken() async {
//     final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
//     final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
//
//     if (refreshToken == null || accessToken == null) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (_) => LoginScreen(),
//         ),
//             (route) => false,
//       );
//     } else {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (_) => RootTab(),
//         ),
//             (route) => false,
//       );
//     }
//   }
//
//   void deleteToken() async {
//     await storage.deleteAll();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultLayout(
//       backgroundColor: PRIMARY_COLOR,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'asset/img/logo/logo.png',
//               width: MediaQuery.of(context).size.width / 2,
//             ),
//             const SizedBox(height: 16.0),
//             CircularProgressIndicator(
//               color: Colors.white,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
