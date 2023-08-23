import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/datetime.dart';

class EmailRegisterScreen extends StatelessWidget {
  const EmailRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '회원가입',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24.0),
                const Text(
                  '트루카운터에서 사용할\n계정 정보를 입력해주세요.',
                  style: titleTextStyle,
                ),
                const SizedBox(height: 48.0),
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
                _SelectedGender(),
                const SizedBox(height: 24.0),
                _BirthYear(),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: defaultButtonStyle,
              child: const Text('회원가입 완료'),
            )
          ],
        ),
      ),
    );
  }
}

class _SelectedGender extends StatefulWidget {
  const _SelectedGender({Key? key}) : super(key: key);

  @override
  State<_SelectedGender> createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<_SelectedGender> {
  bool? isMale;

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
                  setState(() {
                    isMale = false;
                  });
                },
                child: Container(
                  color: BACKGROUND_COLOR,
                  height: 50.0,
                  child: Row(
                    children: [
                      Icon(
                        isMale == null
                            ? Icons.circle_outlined
                            : (isMale!
                                ? Icons.circle_outlined
                                : Icons.check_circle),
                        size: 30.0,
                        color: isMale == null
                            ? DARK_GREY_COLOR
                            : (isMale! ? DARK_GREY_COLOR : PRIMARY_COLOR),
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
                  setState(() {
                    isMale = true;
                  });
                },
                child: Container(
                  color: BACKGROUND_COLOR,
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        isMale == null
                            ? Icons.circle_outlined
                            : (isMale!
                                ? Icons.check_circle
                                : Icons.circle_outlined),
                        size: 30.0,
                        color: isMale == null
                            ? DARK_GREY_COLOR
                            : (isMale! ? PRIMARY_COLOR : DARK_GREY_COLOR),
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
  const _BirthYear({Key? key}) : super(key: key);

  @override
  State<_BirthYear> createState() => _BirthYearState();
}

class _BirthYearState extends State<_BirthYear> {
  DateTime? firstDay;

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
                      firstDay == null
                          ? '선택'
                          : convertDateTimeToDate(datetime: firstDay!),
                      style: descriptionTextStyle,
                    ),
                    const SizedBox(width: 8.0),
                    Icon(Icons.keyboard_arrow_down_rounded)
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
                        setState(() {
                          firstDay = value;
                        });
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
