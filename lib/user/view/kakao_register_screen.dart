import 'package:flutter/cupertino.dart';
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
import 'package:true_counter/user/model/enum/sign_up_type.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';
import 'package:true_counter/user/util/firebase_phone_auth.dart';

class KakaoRegisterScreen extends StatefulWidget {
  final BuildContext beforeContext;

  const KakaoRegisterScreen({
    Key? key,
    required this.beforeContext,
  }) : super(key: key);

  @override
  State<KakaoRegisterScreen> createState() => _KakaoRegisterScreenState();
}

class _KakaoRegisterScreenState extends State<KakaoRegisterScreen> {
  final UserRepositoryInterface _userRepository = UserRepository();

  // form focus
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> phoneFormKey = GlobalKey();
  final FirebasePhoneAuthUtil _firebasePhoneAuthUtil = FirebasePhoneAuthUtil();

  bool isLoading = false;

  FocusNode? phoneFocus;
  FocusNode? certificationFocus;

  bool isVisiblePassword = false; // 패스워드 보이게
  bool isVisiblePasswordCheck = false; // 패스워드 보이게
  bool isRequestCertification = false; // 인증번호 받기
  bool isValidCertification = false; // 인증 번호 확인

  // user info
  String? phoneText;
  String? certificationText;

  // no text form field
  bool? gender;
  DateTime? birthday;
  String? location;

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
      appbar: const DefaultAppBar(
        title: '카카오로 회원가입',
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24.0),
                    const Text(
                      '트루카운터에서 사용할 추가\n계정 정보를 입력해 주세요.',
                      style: headTitleTextStyle,
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

                                    isLoading = false;
                                    setState(() {});

                                    // TODO: 인증번호가 일치하는지 확인
                                    if (isVerified) {
                                      isValidCertification = true;
                                      certificationFocus?.unfocus();
                                      showCustomToast(
                                        context,
                                        msg: '인증번호가 정상적으로 확인되었습니다.',
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
                    const SizedBox(height: 16.0),
                    _SelectedGender(
                      gender: gender,
                      onTap: onGenderSelected,
                    ),
                    const SizedBox(height: 16.0),
                    _BirthYear(
                      birthday: birthday,
                      onDaySelected: onDaySelected,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120.0,
                          child: Text(
                            '거주지역',
                            style: bodyMediumTextStyle,
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
                      onPressed: isRequestCertification &&
                              isValidCertification &&
                              gender != null &&
                              birthday != null &&
                              location != null &&
                              location!.isNotEmpty &&
                              location != '선택' &&
                              formKey.currentState != null &&
                              formKey.currentState!.validate()
                          ? () async {
                              bool isSuccessKakaoSignUp =
                                  await _userRepository.kakaoSignUp(
                                phone: phoneText!,
                                gender: gender!,
                                birthday: convertDateTimeToDateString(
                                    datetime: birthday!),
                                region: location!,
                              );

                              if (isSuccessKakaoSignUp) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  RouteNames.root,
                                  (route) => false,
                                );
                              } else {
                                Navigator.of(context).pop();
                                showCustomToast(
                                  widget.beforeContext,
                                  msg: "계정 문제로 인해 \n카카오로 시작할 수 없습니다.",
                                );
                              }

                              // final isSuccessSignIn =
                              // await _userRepository.signUp(
                              //   email: emailText!,
                              //   password: passwordText!,
                              //   phone: phoneText!,
                              //   birthday: convertDateTimeToOnlyDateString(
                              //     datetime: birthday!,
                              //   ),
                              //   gender: gender!,
                              //   region: location!,
                              //   signUpType: SignUpType.email,
                              // );
                              //
                              // if (isSuccessSignIn) {
                              //   Navigator.of(context).pushNamed(
                              //     RouteNames.terms,
                              //   );
                              // } else {
                              //   showCustomToast(
                              //     context,
                              //     msg: '오류 메세지 입니다.',
                              //   );
                              // }
                            }
                          : null,
                      style: defaultButtonStyle,
                      child: const Text('다음'),
                    )
                  ],
                ),
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
            style: bodyMediumTextStyle,
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
                            style: bodyMediumTextStyle.copyWith(
                              fontSize: 16.0,
                            ),
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
                            style: bodyMediumTextStyle.copyWith(
                              fontSize: 16.0,
                            ),
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

class _BirthYear extends StatefulWidget {
  final DateTime? birthday;
  final void Function({required DateTime birthday})? onDaySelected;

  const _BirthYear({
    Key? key,
    required this.birthday,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  State<_BirthYear> createState() => _BirthYearState();
}

class _BirthYearState extends State<_BirthYear> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 120.0,
          child: Text(
            '생년월일',
            style: bodyMediumTextStyle,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              onBirthPressed();
            },
            child: Container(
              height: 48.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: DARK_GREY_COLOR,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 1.0),
                    Text(
                      widget.birthday == null
                          ? '선택'
                          : convertDateTimeToDateString(
                              datetime: widget.birthday!,
                            ),
                      style: descriptionTextStyle,
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onBirthPressed() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              color: BACKGROUND_COLOR,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.ymd,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime value) {
                        widget.onDaySelected!(birthday: value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Location extends StatefulWidget {
  final String? location;
  final void Function({required String location})? onLocationSelected;

  const _Location({
    Key? key,
    required this.location,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  State<_Location> createState() => _LocationState();
}

class _LocationState extends State<_Location> {
  List<String> locations = [
    '서울특별시',
    '부산광역시',
    '대구광역시',
    '인천광역시',
    '광주광역시',
    '대전광역시',
    '울산광역시',
    '세종특별자치시',
    '경기도',
    '강원도',
    '충청북도',
    '충청남도',
    '전라북도',
    '전라남도',
    '경상북도',
    '경상남도',
    '제주특별자치도',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 120.0,
          child: Text(
            '생년월일',
            style: bodyMediumTextStyle,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              onBirthPressed();
            },
            child: Container(
              height: 48.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: DARK_GREY_COLOR,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text(
                    //   widget.location == null
                    //       ? '선택'
                    //       : convertDateTimeToDate(datetime: widget.location),
                    //   style: descriptionTextStyle,
                    // ),
                    const SizedBox(width: 8.0),
                    const Icon(Icons.keyboard_arrow_down_rounded)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onBirthPressed() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              color: BACKGROUND_COLOR,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('선택'),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.ymd,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime value) {
                        // widget.onDaySelected!(birthday: value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
