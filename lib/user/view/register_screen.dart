import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/component/drop_down_menu.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '회원가입',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 120.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    child: Center(
                      child: Text('ID자동입력', style: bodyBoldWhiteTextStyle),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: CustomTextFormField(),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            CustomTextFormField(
              title: '비밀번호',
            ),
            const SizedBox(height: 24.0),
            CustomTextFormField(
              title: '비밀번호 확인',
            ),
            const SizedBox(height: 24.0),
            _SelectedGender(),
            const SizedBox(height: 24.0),
            _BirthYear(),
            const SizedBox(height: 24.0),
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
  bool isMale = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100.0,
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
                        isMale ? Icons.circle_outlined : Icons.check_circle,
                        size: 30.0,
                        color: isMale ? DARK_GREY_COLOR : PRIMARY_COLOR,
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
                        !isMale ? Icons.circle_outlined : Icons.check_circle,
                        size: 30.0,
                        color: !isMale ? DARK_GREY_COLOR : PRIMARY_COLOR,
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
  DateTime firstDay = DateTime.now();

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
                    Text('선택'),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              color: BACKGROUND_COLOR,
            ),
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
        );
      },
    );
  }
}
