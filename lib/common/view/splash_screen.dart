import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/route/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TRUE COUNTER',
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 36.0),
            const Text(
              '실시간 참여자 수',
              style: TextStyle(
                color: SECONDARY_COLOR,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '집계 시스템',
              style: TextStyle(
                color: SECONDARY_COLOR,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> delay() async {
    Future.delayed(const Duration(seconds: 2), () {
      String startRoute = RouteNames.login;
      Navigator.of(context).popAndPushNamed(startRoute);
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
