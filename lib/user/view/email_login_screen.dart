import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/route/routes.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  bool isAutoLogin = true;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '이메일 로그인',
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
                title: '이메일',
                hintText: '이메일 입력',
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '비밀번호',
                hintText: '비밀번호 입력',
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
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteNames.terms,
                  );
                },
                style: defaultButtonStyle,
                child: const Text('로그인'),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteNames.register,
                        );
                      },
                      child: const Text(
                        '회원가입',
                        style: descriptionGreyTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    color: DARK_GREY_COLOR,
                    width: 1.0,
                    height: 14.0,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteNames.passwordReset,
                        );
                      },
                      child: const Text(
                        '비밀번호 초기화',
                        style: descriptionGreyTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
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
        style: descriptionTextStyle,
      ),
      Text(
        '행사장 반경 안에 있는 누구나 참여 가능합니다.',
        style: descriptionTextStyle,
      ),
    ],
  );
}
