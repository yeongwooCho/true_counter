import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/model/user_model.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final UserRepositoryInterface _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '',
        elevation: 0.0,
        action: [
          TextButton(
            onPressed: () {
              UserModel.dummyLogin();

              Navigator.of(context).pushNamed(
                RouteNames.root,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '둘러보기',
                  style: MyTextStyle.bodyBold.copyWith(
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
                Text(
                  '당신의 참여가 역사가 됩니다.',
                  style: MyTextStyle.bodyTitleBold.copyWith(
                    color: DARK_GREY_COLOR,
                  ),
                ),
                Text(
                  'TRUE COUNTER',
                  style: MyTextStyle.appName.copyWith(
                    color: PRIMARY_COLOR,
                  ),
                ),
                const SizedBox(height: 36.0),
                Text(
                  '실시간 참여자 수',
                  style: MyTextStyle.headTitle.copyWith(
                    color: SECONDARY_COLOR,
                  ),
                ),
                Text(
                  '집계 시스템',
                  style: MyTextStyle.headTitle.copyWith(
                    color: SECONDARY_COLOR,
                  ),
                ),
                const SizedBox(height: 24.0),
                const Text(
                  '트루카운터는 행사 취지에 공감하고',
                  style: MyTextStyle.descriptionRegular,
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '행사장 반경 안에 있는\n누구나 참여 가능합니다.',
                  style: MyTextStyle.descriptionRegular,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // TODO: 카카오 로그인 구현
                    print('카카오 로그인 버튼 누름');

                    final bool isSuccessKakaoSignIn =
                    await _userRepository.kakaoSignIn();

                    if (isSuccessKakaoSignIn) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteNames.root,
                            (route) => false,
                      );
                    } else {
                      Navigator.of(context).pushNamed(
                        RouteNames.snsRegister,
                        arguments: ScreenArguments<bool>(
                          data: true
                        ),
                      );
                    }
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
                if (Platform.isIOS) const SizedBox(height: 16.0),
                if (Platform.isIOS)
                  ElevatedButton(
                    onPressed: () async {
                      final bool isSuccessAppleSignIn =
                          await _userRepository.appleSignIn();
                      if (isSuccessAppleSignIn) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RouteNames.root,
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).pushNamed(
                          RouteNames.snsRegister,
                          arguments: ScreenArguments<bool>(
                            data: false,
                          ),
                        );
                      }
                    },
                    style: appleLoginButtonStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'asset/img/sns/apple.svg',
                          colorFilter: const ColorFilter.mode(
                            WHITE_TEXT_COLOR,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('Apple로 시작하기'),
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
                      style: MyTextStyle.bodyMedium.copyWith(
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
