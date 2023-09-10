import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/repository/user_repository.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final UserRepository _userRepository = UserRepository();

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
                  style: bodyBoldTextStyle.copyWith(
                    color: DARK_GREY_COLOR,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: DARK_GREY_COLOR,
                ),
              ],
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
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
                const Text(
                  '트루카운터는 행사 취지에 공감하고',
                  style: descriptionTextStyle,
                ),
                const Text(
                  '행사장 반경 안에 있는 누구나 참여 가능합니다.',
                  style: descriptionTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // TODO: 카카오 로그인 구현
                    // _userRepository.kakaoLogin();

                    print('카카오 로그인');
                  },
                  style: kakaoLoginButtonStyle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('asset/img/sns/kakao.svg'),
                      const SizedBox(width: 12),
                      const Text('카카오로 3초 만에 시작하기'),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RouteNames.emailLogin,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: DARK_GREY_COLOR,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Text(
                      '이메일로 로그인하기',
                      style: bodyMediumTextStyle.copyWith(
                        color: DARK_GREY_COLOR,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
