import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:true_counter/common/route/routes.dart';
import 'package:true_counter/common/view/splash_screen.dart';
import 'package:true_counter/user/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      onGenerateRoute: (RouteSettings settings) {
        log('current settings: $settings');
        return MaterialPageRoute(
          builder: routes[settings.name!]!,
          settings: settings,
        );
      },
      home: SplashScreen(),
    );
  }
}
