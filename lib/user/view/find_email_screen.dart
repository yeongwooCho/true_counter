import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/regular_expression_pattern.dart';

class FindEmailScreen extends StatefulWidget {
  const FindEmailScreen({Key? key}) : super(key: key);

  @override
  State<FindEmailScreen> createState() => _FindEmailScreenState();
}

class _FindEmailScreenState extends State<FindEmailScreen> {
  // form focus
  final GlobalKey<FormState> formKey = GlobalKey();
  FocusNode phoneFocus = FocusNode();
  FocusNode certificationFocus = FocusNode();

  String? phoneText;
  String? certificationText;
  bool isPressedCertificationResponse = false;
  bool isValidCertification = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
                  '이메일 찾기를 위해\n휴대폰 인증을 해주세요.',
                  style: headTitleTextStyle,
                ),
                const SizedBox(height: 48.0),
                CustomTextFormField(
                  onChanged: (String? value) {
                    phoneText = value;
                  },
                  onSaved: (String? value) {
                    phoneText = value;
                  },
                  validator: TextValidator.phoneValidator,
                  focusNode: phoneFocus,
                  onEditingComplete: () {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      phoneFocus.unfocus();
                    }
                  },
                  title: '휴대폰 번호',
                  hintText: '예) 01012341234',
                  buttonText: '인증번호 받기',
                  onPressedButton: isValidCertification
                      ? null
                      : () {
                          // TODO: 휴대폰 번호에 인증코드 전송번호 전달
                          isPressedCertificationResponse = true;
                          certificationFocus.requestFocus();
                          showCustomToast(
                            context,
                            msg: '인증번호가 전송되었습니다.',
                          );
                          setState(() {});
                        },
                  textInputType: TextInputType.phone,
                  enabled: isValidCertification ? false : true,
                ),
                const SizedBox(height: 4.0),
                if (isPressedCertificationResponse)
                  CustomTextFormField(
                    onSaved: (String? value) {
                      certificationText = value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                    focusNode: certificationFocus,
                    onEditingComplete: () {
                      if (formKey.currentState != null &&
                          formKey.currentState!.validate()) {
                        certificationFocus.unfocus();
                      }
                    },
                    hintText: '인증번호 입력',
                    buttonText: '인증번호 확인',
                    onPressedButton: isValidCertification
                        ? null
                        : () {
                            // TODO: 인증번호가 일치하는지 확인
                            if (true) {
                              isValidCertification = true;
                              certificationFocus.unfocus();
                              showCustomToast(
                                context,
                                msg: '인증번호이 정상적으로 확인되었습니다.',
                              );
                              setState(() {});
                            } else {
                              showCustomToast(
                                context,
                                msg: '인증번호가 일치하지 않습니다.',
                              );
                            }
                          },
                    enabled: isValidCertification ? false : true,
                  ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: isValidCertification ? () {} : null,
                  style: defaultButtonStyle,
                  child: const Text('인증 완료'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
