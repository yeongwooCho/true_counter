import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class EmailPasswordResetScreen extends StatelessWidget {
  const EmailPasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '비밀번호 초기화',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24.0),
            const Text(
              '비밀 번호 초기화를 위해\n휴대폰 인증을 해주세요.',
              style: titleTextStyle,
            ),
            const SizedBox(height: 48.0),
            CustomTextFormField(
              title: '휴대폰 번호',
              buttonText: '인증번호 받기',
              onPressedButton: (){},
            ),
            const SizedBox(height: 8.0),
            CustomTextFormField(
              buttonText: '인증번호 확인',
              onPressedButton: (){},
            ),
            const SizedBox(height: 48.0),
            ElevatedButton(
              onPressed: () {},
              style: defaultButtonStyle,
              child: const Text('인증 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
