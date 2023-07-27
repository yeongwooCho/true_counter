import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '',
        elevation: 0.0,
        action: [
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '둘러보기',
                  style: TextStyle(
                    color: DARK_GREY_COLOR,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: DARK_GREY_COLOR,
                ),
              ],
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          renderIntroduceWidget(),
        ],
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
        height: 48.0,
      ),
      const Text(
        'TRUE COUNTER',
        style: TextStyle(
          color: PRIMARY_COLOR,
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 36.0),
      const Text(
        '실시간 참여자 수',
        style: TextStyle(
          color: SECONDARY_COLOR,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        '집계 시스템',
        style: TextStyle(
          color: SECONDARY_COLOR,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 24.0),
      const Text(
        '트루카운터는 행사 취지에 공감하고',
        style: TextStyle(
          color: DEFAULT_TEXT_COLOR,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      const Text(
        '행사장 반경 안에 있는 누구나 참여 가능합니다.',
        style: TextStyle(
          color: DEFAULT_TEXT_COLOR,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );
}
