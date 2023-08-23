import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/view/on_boarding_screen.dart';
import 'package:true_counter/common/view/root_tab.dart';
import 'package:true_counter/user/view/email_login_screen.dart';
import 'package:true_counter/user/view/email_register_completion_screen.dart';
import 'package:true_counter/user/view/email_password_reset_screen.dart';
import 'package:true_counter/user/view/email_register_screen.dart';
import 'package:true_counter/user/view/terms_providing_info_screen.dart';
import 'package:true_counter/user/view/terms_screen.dart';

class RouteNames {
  // initial
  static const String splash = '/';

  // onBoarding, login, register, findID, passwordReset
  static const String onBoarding = '/onBoarding';

  static const String emailLogin = '/email/login';
  static const String emailRegister = '/email/register';
  static const String emailPasswordReset = 'email/password/reset';
  static const String terms = '/terms';
  static const String termsProviding = '/terms/providing';
  static const String emailRegisterCompletion = '/email/register/completion';

  // root tab
  static const String root = '/root';

// // custom
// static const String selectFabric = '/select/fabric';
// static const String printing = '/printing';
// static const String customGuide = '/custom/guide';
//
// // search
// static const String productDetail = '/product/detail';
//
// // purchase
// static const String purchase = '/purchase';
}

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // // global
  // RouteNames.completion: (context) {
  //   final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
  //   String title = '';
  //   if (args.title == 'title') {
  //     title = args.message;
  //   } else {
  //     title = '_';
  //   }
  //   return CompletionScreen(title: title);
  // },

  // onBoarding, login, register, findID, passwordReset
  RouteNames.onBoarding: (_) => OnBoardingScreen(),
  RouteNames.emailLogin: (_) => EmailLoginScreen(),
  RouteNames.emailRegister: (_) => EmailRegisterScreen(),
  RouteNames.terms: (_) => TermsScreen(),
  RouteNames.termsProviding: (_) => TermsProvidingInfoScreen(),
  RouteNames.emailPasswordReset: (_) => EmailPasswordResetScreen(),
  RouteNames.emailRegisterCompletion: (_) => EmailRegisterCompletionScreen(),

  // root tab
  RouteNames.root: (_) => RootTab(),
  //
  // // custom
  // RouteNames.customGuide: (_) => CustomGuideScreen(),
  // RouteNames.selectFabric: (context) {
  //   final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
  //   String id = '';
  //   if (args.title == 'id') {
  //     id = args.message;
  //   } else {
  //     id = '0';
  //   }
  //   return SelectFabricScreen(id: id);
  // },
  // RouteNames.printing: (context) {
  //   final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
  //   String id = '';
  //   if (args.title == 'id') {
  //     id = args.message;
  //   } else {
  //     id = '0';
  //   }
  //   return PrintingScreen(id: id);
  // },
  //
  // // search
  // RouteNames.productDetail: (context) {
  //   final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
  //   String id = '';
  //   if (args.title == 'id') {
  //     id = args.message;
  //   } else {
  //     id = '0';
  //   }
  //   return ProductDetailScreen(id: id);
  // },
  //
  // // purchase
  // RouteNames.purchase: (context) {
  //   final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
  //   String id = '';
  //   if (args.title == 'id') {
  //     id = args.message;
  //   } else {
  //     id = '0';
  //   }
  //   return PurchaseScreen(id: id);
  // },
};

// Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//   // global
//   RouteNames.completion: (context) {
//     final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
//     String title = '';
//     if (args.title == 'title') {
//       title = args.message;
//     } else {
//       title = '_';
//     }
//     return CompletionScreen(title: title);
//   },
//
//   // login, register, findID, passwordReset
//   RouteNames.login: (_) => LoginScreen(),
//   RouteNames.emailLogin: (_) => EmailLoginScreen(),
//   RouteNames.emailRegister: (_) => EmailRegisterScreen(),
//   RouteNames.emailFind: (_) => EmailFindScreen(),
//   RouteNames.emailPasswordReset: (_) => EmailPasswordResetScreen(),
//   RouteNames.terms: (_) => TermsScreen(),
//
//   // root tab
//   RouteNames.root: (_) => RootTab(),
//
//   // custom
//   RouteNames.customGuide: (_) => CustomGuideScreen(),
//   RouteNames.selectFabric: (context) {
//     final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
//     String id = '';
//     if (args.title == 'id') {
//       id = args.message;
//     } else {
//       id = '0';
//     }
//     return SelectFabricScreen(id: id);
//   },
//   RouteNames.printing: (context) {
//     final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
//     String id = '';
//     if (args.title == 'id') {
//       id = args.message;
//     } else {
//       id = '0';
//     }
//     return PrintingScreen(id: id);
//   },
//
//   // search
//   RouteNames.productDetail: (context) {
//     final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
//     String id = '';
//     if (args.title == 'id') {
//       id = args.message;
//     } else {
//       id = '0';
//     }
//     return ProductDetailScreen(id: id);
//   },
//
//   // purchase
//   RouteNames.purchase: (context) {
//     final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
//     String id = '';
//     if (args.title == 'id') {
//       id = args.message;
//     } else {
//       id = '0';
//     }
//     return PurchaseScreen(id: id);
//   },
// };
