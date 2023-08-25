import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/route/routes.dart';

class EmailRegisterCompletionScreen extends StatelessWidget {
  const EmailRegisterCompletionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 112.0),
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
                    '회원가입이 완료 되었습니다.',
                    style: titleTextStyle,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.root,
                      (route) => false,
                );
              },
              style: defaultButtonStyle,
              child: const Text('홈으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
