import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:true_counter/common/route/routes.dart';
import 'package:true_counter/common/view/splash_screen.dart';
import 'package:true_counter/user/view/email_register_completion_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  if (kDebugMode) {
    await dotenv.load(fileName: 'asset/config/.development.env');
  } else {
    await dotenv.load(fileName: 'asset/config/.production.env');
  }

  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ko', ''), // Korean, no country code
      ],
      onGenerateRoute: (RouteSettings settings) {
        log('current settings: $settings');
        return MaterialPageRoute(
          builder: routes[settings.name!]!,
          settings: settings,
        );
      },
      // home: SplashScreen(),
      home: EmailRegisterCompletionScreen()
    );
  }
}
