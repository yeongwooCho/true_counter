import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_drop_down_button.dart';
import 'package:true_counter/common/component/custom_loading.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/util/regular_expression_pattern.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';

class SnsRegisterScreen extends StatefulWidget {
  final bool isKakao;
  final String? appleEmail;

  const SnsRegisterScreen({
    Key? key,
    required this.isKakao,
    this.appleEmail,
  }) : super(key: key);

  @override
  State<SnsRegisterScreen> createState() => _SnsRegisterScreenState();
}

class _SnsRegisterScreenState extends State<SnsRegisterScreen> {
  final UserRepositoryInterface _userRepository = UserRepository();
  final GlobalKey<FormState> phoneFormKey = GlobalKey();

  bool isLoading = false;

  String? phoneText;
  bool? gender;
  DateTime birthday = now;
  String? location;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: widget.isKakao ? "카카오로 회원가입" : "애플로 회원가입",
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24.0),
                  const Text(
                    '트루카운터에서 사용할 추가\n계정 정보를 입력해 주세요.',
                    style: MyTextStyle.headTitle,
                  ),
                  const SizedBox(height: 24.0),

                  Text(
                    '휴대폰 번호와 출생연도는\n“본인인증” 및 “중복참여방지”에\n가장 중요한 기초 데이터 입니다.',
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: DARK_GREY_COLOR,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    '휴대폰 번호와 출생연도를\n정확히 입력해 주세요.',
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: DARK_GREY_COLOR,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  Form(
                    key: phoneFormKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: CustomTextFormField(
                      onChanged: (String? value) {
                        phoneText = value;
                        setState(() {});
                      },
                      onSaved: (String? value) {
                        phoneText = value;
                      },
                      validator: TextValidator.phoneValidator,
                      // focusNode: phoneFocus,
                      title: '휴대폰 번호',
                      hintText: '예) 01012341234',
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _SelectedGender(
                    gender: gender,
                    onTap: onGenderSelected,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120.0,
                        child: Text(
                          '출생년도',
                          style: MyTextStyle.bodyTitleBold,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: CustomDropDownButton(
                          dropdownList: List<String>.generate(100, (index) {
                            return "${now.year - index} 년";
                          }),
                          defaultValue: "${birthday.year} 년",
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            int selectedYear =
                                int.parse(value.split(' ').first);
                            birthday =
                                convertBirthdayDateTime(year: selectedYear);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120.0,
                        child: Text(
                          '거주지역',
                          style: MyTextStyle.bodyTitleBold,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: CustomDropDownButton(
                          dropdownList: registerLocation,
                          defaultValue: location == null ? '선택' : location!,
                          onChanged: (String? value) {
                            location = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: gender != null &&
                            location != null &&
                            location!.isNotEmpty &&
                            location != '선택' &&
                            phoneFormKey.currentState != null &&
                            phoneFormKey.currentState!.validate() &&
                            phoneText != null &&
                            phoneText!.isNotEmpty
                        ? () async {
                            late bool isSuccessSignUp;

                            if (widget.isKakao) {
                              isSuccessSignUp =
                                  await _userRepository.kakaoSignUp(
                                phone: phoneText!,
                                gender: gender!,
                                birthday: convertDateTimeToDateString(
                                  datetime: birthday,
                                ),
                                region: location!,
                              );
                            } else {
                              isSuccessSignUp =
                                  await _userRepository.appleSignUp(
                                phone: phoneText!,
                                gender: gender!,
                                birthday: convertDateTimeToDateString(
                                  datetime: birthday,
                                ),
                                region: location!,
                              );
                            }

                            if (isSuccessSignUp) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteNames.root,
                                (route) => false,
                              );
                            } else {
                              Navigator.of(context).pop();
                              showCustomToast(
                                context,
                                msg:
                                    "계정 문제로 인해 \n${widget.isKakao ? '카카오' : '애플'}로 시작할 수 없습니다.",
                              );
                            }
                          }
                        : null,
                    style: defaultButtonStyle,
                    child: const Text('다음'),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: isLoading,
              child: const CustomLoadingScreen(),
            ),
          )
        ],
      ),
    );
  }

  void onGenderSelected({required bool gender}) {
    setState(() {
      this.gender = gender;
    });
  }

  void onDaySelected({required DateTime birthday}) {
    setState(() {
      this.birthday = birthday;
    });
  }
}

class _SelectedGender extends StatefulWidget {
  final bool? gender;
  final void Function({required bool gender})? onTap;

  const _SelectedGender({
    Key? key,
    required this.gender,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_SelectedGender> createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<_SelectedGender> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 120.0,
          child: Text(
            '성별 선택',
            style: MyTextStyle.bodyTitleBold,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(gender: false);
                  }
                },
                child: Container(
                  color: BACKGROUND_COLOR,
                  height: 50.0,
                  child: Row(
                    children: [
                      Icon(
                        widget.gender == null
                            ? Icons.circle_outlined
                            : (widget.gender!
                                ? Icons.circle_outlined
                                : Icons.check_circle),
                        size: 30.0,
                        color: widget.gender == null
                            ? DARK_GREY_COLOR
                            : (widget.gender!
                                ? DARK_GREY_COLOR
                                : PRIMARY_COLOR),
                      ),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            '여성',
                            style: MyTextStyle.descriptionMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(gender: true);
                  }
                },
                child: Container(
                  color: BACKGROUND_COLOR,
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.gender == null
                            ? Icons.circle_outlined
                            : (widget.gender!
                                ? Icons.check_circle
                                : Icons.circle_outlined),
                        size: 30.0,
                        color: widget.gender == null
                            ? DARK_GREY_COLOR
                            : (widget.gender!
                                ? PRIMARY_COLOR
                                : DARK_GREY_COLOR),
                      ),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            '남성',
                            style: MyTextStyle.descriptionMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
