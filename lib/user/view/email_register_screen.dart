import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/route/routes.dart';
import 'package:true_counter/common/util/datetime.dart';

class EmailRegisterScreen extends StatefulWidget {
  const EmailRegisterScreen({Key? key}) : super(key: key);

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen> {
  bool? gender;
  DateTime? birthday;

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

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '회원가입',
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              const Text(
                '트루카운터에서 사용할\n계정 정보를 입력해주세요.',
                style: titleTextStyle,
              ),
              const SizedBox(height: 32.0),
              CustomTextFormField(
                title: '이메일',
                hintText: 'ex) qwer1234@naver.com',
                buttonText: '중복확인',
                onPressedButton: () {},
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '비밀번호',
                hintText: '영문, 숫자 합 7자리 이상',
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '비밀번호 확인',
                hintText: '영문, 숫자 합 7자리 이상',
              ),
              const SizedBox(height: 24.0),
              _SelectedGender(
                gender: gender,
                onTap: onGenderSelected,
              ),
              const SizedBox(height: 24.0),
              _BirthYear(
                birthday: birthday,
                onDaySelected: onDaySelected,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: gender == null || birthday == null ? null : () {
                  Navigator.of(context).pushNamed(RouteNames.terms);
                },
                style: defaultButtonStyle,
                child: const Text('다음'),
              )
            ],
          ),
        ),
      ),
    );
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
                  widget.onTap!(gender: false);
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
                  widget.onTap!(gender: true);
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.birthday == null
                          ? '선택'
                          : convertDateTimeToDate(datetime: widget.birthday!),
                      style: descriptionTextStyle,
                    ),
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
