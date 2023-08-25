import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/route/routes.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/regular_expression_pattern.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  String? emailText;
  String? passwordText;

  TextEditingController emailTextController = TextEditingController();

  bool isAutoLogin = true; // 자동 로그인 선택 여부

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '이메일 로그인',
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                renderIntroduceWidget(),
                const SizedBox(height: 48.0),
                CustomTextFormField(
                  onSaved: (String? value) {
                    emailText = value;
                  },
                  validator: emailValidator,
                  focusNode: emailFocus,
                  onEditingComplete: () {
                    if (formKey.currentState!.validate()) {
                      passwordFocus.requestFocus();
                    } else {
                      emailFocus.requestFocus();
                    }
                  },
                  title: '이메일',
                  hintText: '이메일 입력',
                ),
                const SizedBox(height: 24.0),
                CustomTextFormField(
                  onSaved: (String? value) {
                    passwordText = value;
                  },
                  validator: passwordValidator,
                  focusNode: passwordFocus,
                  onEditingComplete: () {
                    if (formKey.currentState!.validate()) {
                      passwordFocus.unfocus();
                    }
                  },
                  title: '비밀번호',
                  hintText: '비밀번호 입력',
                  obscureText: true,
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
                  onPressed: () => onLoginPressed(context),
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
                            RouteNames.emailRegister,
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
                            RouteNames.emailPasswordReset,
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
      ),
    );
  }

  String? emailValidator(String? val) {
    if (val == null || val.isEmpty) {
      // return '이메일을 입력 해주세요';
      return null;
    }

    if (!val.isValidEmailFormat()) {
      return '알맞은 이메일 형식을 입력 해주세요.';
    }

    return null;
  }

  String? passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      // return '값을 입력해주세요';
      return null;
    }

    if (!val.isValidPasswordFormat()) {
      return '영문,숫자,특수문자 포함 8~15자로 입력 해주세요.';
    }

    return null;
  }

  void onLoginPressed(BuildContext context) {
    // 해당 키를 가진 TextFormField 의 validate()를 모두 호출
    if (formKey.currentState!.validate()) {
      // 해당 키를 가진 TextFormField 의 onSaved()를 모두 호출
      formKey.currentState!.save();
    }


    if (emailText == null ||
        passwordText == null ||
        emailText!.isEmpty ||
        passwordText!.isEmpty) {
      showCustomToast(context, '올바른 계정 정보를 입력해주세요.');
    } else {
      // TODO: 로그인 제어
      Navigator.of(context).pushNamed(
        RouteNames.root,
      );
      // context.read<ScheduleProvider>().createSchedule(
      //     schedule: ScheduleModel(
      //       id: 'new_model',
      //       content: content!,
      //       date: widget.selectedDate,
      //       startTime: startTime!,
      //       endTime: endTime!,
      //     ));
      //
      // Navigator.of(context).pop();
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
}
