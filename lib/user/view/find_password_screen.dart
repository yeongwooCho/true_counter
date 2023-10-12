import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_drop_down_button.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/regular_expression_pattern.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/model/token_model.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';
import 'package:true_counter/user/util/firebase_phone_auth.dart';

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({Key? key}) : super(key: key);

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  final UserRepositoryInterface userRepository = UserRepository();
  final FirebasePhoneAuthUtil _firebasePhoneAuthUtil = FirebasePhoneAuthUtil();

  // form focus
  final GlobalKey<FormState> emailFormKey = GlobalKey();
  final GlobalKey<FormState> phoneFormKey = GlobalKey();
  FocusNode? emailFocus;
  FocusNode? phoneFocus;
  FocusNode? certificationFocus;

  String? emailText;
  String? phoneText;
  String? certificationText;
  bool isRequestCertification = false;
  bool isValidCertification = false;

  DateTime? birthday;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    phoneFocus = FocusNode();
    certificationFocus = FocusNode();
  }

  @override
  void dispose() {
    phoneFocus?.dispose();
    certificationFocus?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      isLoading: isLoading,
      appbar: const DefaultAppBar(
        title: '비밀번호 찾기',
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              const Text(
                '비밀번호 찾기를 위해\n휴대폰 인증을 해주세요.',
                style: headTitleTextStyle,
              ),
              const SizedBox(height: 48.0),
              Form(
                key: emailFormKey,
                autovalidateMode: AutovalidateMode.always,
                child: CustomTextFormField(
                  onChanged: (String? value) {
                    emailText = value;
                  },
                  onSaved: (String? value) {},
                  validator: TextValidator.emailValidator,
                  focusNode: emailFocus,
                  title: '이메일',
                  hintText: '이메일 입력',
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 32.0),
              CustomTextFormField(
                onChanged: (String? value) {
                  phoneText = value;
                  setState(() {});
                },
                onSaved: (String? value) {
                  phoneText = value;
                },
                validator: TextValidator.phoneValidator,
                focusNode: phoneFocus,
                onEditingComplete: () {
                  if (phoneFormKey.currentState != null &&
                      phoneFormKey.currentState!.validate()) {
                    phoneFocus?.unfocus();
                  }
                },
                title: '휴대폰 번호',
                hintText: '예) 01012341234',
                buttonText: isValidCertification ? '인증 완료' : '인증번호 받기',
                onPressedButton: isValidCertification ||
                        phoneText == null ||
                        phoneText!.isEmpty
                    ? null
                    : () async {
                        isLoading = true;
                        isRequestCertification = true;
                        setState(() {});

                        if (isRequestCertification) {
                          certificationFocus?.requestFocus();
                        } else {
                          phoneFocus?.requestFocus();
                        }

                        // TODO: 휴대폰 번호에 인증코드 전송번호 전달
                        await _firebasePhoneAuthUtil.requestSmsCode(
                          context: context,
                          phone: phoneText!,
                        );

                        isLoading = false;
                        setState(() {});
                      },
                textInputType: TextInputType.number,
                enabled: isValidCertification ? false : true,
              ),
              const SizedBox(height: 4.0),
              if (isRequestCertification && !isValidCertification)
                CustomTextFormField(
                  onChanged: (String? value) {
                    certificationText = value;
                    setState(() {});
                  },
                  onSaved: (String? value) {
                    certificationText = value;
                  },
                  validator: (String? value) {
                    return null;
                  },
                  focusNode: certificationFocus,
                  hintText: '인증번호 입력',
                  buttonText: '인증번호 확인',
                  onPressedButton:
                      isValidCertification || certificationText == null
                          ? null
                          : () async {
                              isLoading = true;
                              setState(() {});

                              bool isVerified =
                                  await _firebasePhoneAuthUtil.verifyUser(
                                smsCode: certificationText!,
                              );

                              // TODO: 인증번호가 일치하는지 확인
                              if (isVerified) {
                                isValidCertification = true;
                                certificationFocus?.unfocus();

                                showCustomToast(
                                  context,
                                  msg: '정상적으로 확인되었습니다.',
                                );
                                setState(() {});
                              } else {
                                showCustomToast(
                                  context,
                                  msg: '인증번호가 일치하지 않습니다.',
                                );
                              }
                              isLoading = false;
                              setState(() {});
                            },
                  enabled: isValidCertification ? false : true,
                ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  const SizedBox(
                    width: 120.0,
                    child: Text(
                      '출생년도',
                      style: bodyTitleBoldTextStyle,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: CustomDropDownButton(
                      dropdownList: List<String>.generate(100, (index) {
                        return "${now.year - index} 년";
                      }),
                      defaultValue: birthday == null
                          ? "${now.year} 년"
                          : "${birthday!.year} 년",
                      onChanged: (String? value) {
                        if (value == null) {
                          return;
                        }
                        int selectedYear = int.parse(value.split(' ').first);
                        birthday = DateTime(selectedYear);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48.0),
              ElevatedButton(
                onPressed: emailText != null &&
                        emailText!.isNotEmpty &&
                        isValidCertification &&
                        birthday != null &&
                        phoneText != null &&
                        phoneText!.isNotEmpty
                    ? () async {
                        isLoading = true;
                        setState(() {});
                        final isSuccess = await userRepository.findPassword(
                          email: emailText!,
                          birthday: birthday!,
                          phone: phoneText!,
                        );
                        isLoading = false;
                        setState(() {});

                        if (isSuccess) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteNames.findPasswordChange,
                            (route) => false,
                          );
                        } else {
                          showCustomToast(
                            context,
                            msg: "진행 도중 에러가 발생했습니다.",
                          );
                        }
                      }
                    : null,
                style: defaultButtonStyle,
                child: const Text('인증 완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
