import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/regular_expression_pattern.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';

class FindPasswordChangeScreen extends StatefulWidget {
  const FindPasswordChangeScreen({Key? key}) : super(key: key);

  @override
  State<FindPasswordChangeScreen> createState() =>
      _FindPasswordChangeScreenState();
}

class _FindPasswordChangeScreenState extends State<FindPasswordChangeScreen> {
  final UserRepositoryInterface userRepository = UserRepository();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool isVisiblePassword = false; // 패스워드 보이게
  bool isVisiblePasswordCheck = false; // 패스워드 보이게
  String? passwordText;
  String? passwordCheckText;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      isLoading: isLoading,
      appbar: const DefaultAppBar(
        title: '이메일 찾기',
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24.0),
                const Text(
                  '새로운 비밀번호를\n입력해 주세요.',
                  style: headTitleTextStyle,
                ),
                const SizedBox(height: 48.0),
                CustomTextFormField(
                  obscureText: !isVisiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      isVisiblePassword = !isVisiblePassword;
                      setState(() {});
                    },
                    icon: Icon(
                      isVisiblePassword
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: DEFAULT_TEXT_COLOR,
                    ),
                  ),
                  onChanged: (String? value) {
                    passwordText = value;
                    setState(() {});
                  },
                  onSaved: (String? value) {
                    passwordText = value;
                  },
                  validator: TextValidator.passwordValidator,
                  title: '새 비밀번호',
                  hintText: '영문, 숫자, 특수문자 포함 8~15자',
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  obscureText: !isVisiblePasswordCheck,
                  suffixIcon: IconButton(
                    onPressed: () {
                      isVisiblePasswordCheck = !isVisiblePasswordCheck;
                      setState(() {});
                    },
                    icon: Icon(
                      isVisiblePasswordCheck
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: DEFAULT_TEXT_COLOR,
                    ),
                  ),
                  onChanged: (String? value) {
                    passwordCheckText = value;
                    setState(() {});
                  },
                  onSaved: (String? value) {
                    passwordCheckText = value;
                  },
                  validator: (String? value) {
                    return TextValidator.passwordCheckValidator(
                      passwordText,
                      value,
                    );
                  },
                  title: '새 비밀번호 확인',
                  hintText: '영문, 숫자, 특수문자 포함 8~15자',
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 48.0),
                ElevatedButton(
                  onPressed: passwordText == passwordCheckText &&
                          passwordText != null &&
                          passwordText!.isNotEmpty &&
                          passwordCheckText != null &&
                          passwordCheckText!.isNotEmpty &&
                          formKey.currentState != null &&
                          formKey.currentState!.validate()
                      ? () async {
                          setState(() {
                            isLoading = true;
                          });
                          final isSuccess = await userRepository.changePassword(
                            newPassword: passwordText!,
                          );
                          setState(() {
                            isLoading = false;
                          });

                          if (isSuccess) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              RouteNames.findPasswordCompletion,
                              (route) => false,
                            );
                          } else {
                            showCustomToast(
                              context,
                              msg: "비밀번호를 변경하지\n못했습니다.",
                            );
                          }
                        }
                      : null,
                  style: defaultButtonStyle,
                  child: const Text("확인"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
