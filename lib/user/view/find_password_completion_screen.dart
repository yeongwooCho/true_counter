import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';

class FindPasswordCompletionScreen extends StatelessWidget {
  const FindPasswordCompletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: "비밀번호 찾기 완료"),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 1.0),
            const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 48.0,
                    color: PRIMARY_COLOR,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    '비밀번호가 정상적으로\n변경 되었습니다.',
                    style: headTitleTextStyle,
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
