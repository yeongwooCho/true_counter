import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';

class FindEmailCompletionScreen extends StatelessWidget {
  final String email;

  const FindEmailCompletionScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: "이메일 확인",
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 1.0),
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 48.0,
                    color: PRIMARY_COLOR,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    '회원님의 이메일은\n$email\n입니다.',
                    style: MyTextStyle.headTitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.onBoarding,
                  (route) => false,
                );
              },
              style: defaultButtonStyle,
              child: const Text('시작 화면으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
