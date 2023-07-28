import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAutoLogin = true;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '',
        elevation: 0.0,
        action: [
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '둘러보기',
                  style: bodyBoldTextStyle.copyWith(
                    color: DARK_GREY_COLOR,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: DARK_GREY_COLOR,
                ),
              ],
            ),
          ),
        ],
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              renderIntroduceWidget(),
              const SizedBox(height: 48.0),
              CustomTextFormField(
                title: '아이디',
                hintText: '휴대전화번호 뒤 8자리',
              ),
              const SizedBox(height: 12.0),
              CustomTextFormField(
                title: '비밀번호',
                hintText: '비밀번호',
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    '자동 로그인',
                    style: bodyBoldTextStyle,
                  ),
                  const SizedBox(width: 6.0),
                  CupertinoSwitch(
                    activeColor: PRIMARY_COLOR,
                    value: isAutoLogin,
                    onChanged: (bool value) {
                      setState(() {
                        isAutoLogin = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {},
                style: defaultButtonStyle,
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget renderIntroduceWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        width: double.infinity,
        height: 36.0,
      ),
      Text(
        'TRUE COUNTER',
        style: appNameTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
      ),
      const SizedBox(height: 36.0),
      Text(
        '실시간 참여자 수',
        style: titleTextStyle.copyWith(
          color: SECONDARY_COLOR,
        ),
      ),
      Text(
        '집계 시스템',
        style: titleTextStyle.copyWith(
          color: SECONDARY_COLOR,
        ),
      ),
      const SizedBox(height: 24.0),
      Text(
        '트루카운터는 행사 취지에 공감하고',
        style: bodyMediumTextStyle.copyWith(
          fontSize: 16.0,
        ),
      ),
      Text(
        '행사장 반경 안에 있는 누구나 참여 가능합니다.',
        style: bodyMediumTextStyle.copyWith(
          fontSize: 16.0,
        ),
      ),
    ],
  );
}
