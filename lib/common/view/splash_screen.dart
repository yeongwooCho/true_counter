import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/notification/repository/notification_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationRepository notificationRepository = NotificationRepository();

  @override
  void initState() {
    super.initState();

    notificationRepository.getNotification();
    delay();
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

  Future<void> delay() async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).popAndPushNamed(
        RouteNames.onBoarding,
      );
    });
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
