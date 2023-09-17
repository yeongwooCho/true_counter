import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '회원탈퇴',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24.0),
                const Text(
                  '회원 탈퇴 시\n아래의 주의사항을 꼭 읽어주세요.',
                  style: titleTextStyle,
                ),
                const SizedBox(height: 24.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '◦ 탈퇴 시 회원님의 휴대전화 정보를 포함한 모든 개인 정보는 삭제됩니다.',
                    style: descriptionGreyTextStyle,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '◦ 기존에 참여한 카운터 정보는 유지됩니다.',
                    style: descriptionGreyTextStyle,
                  ),
                ),
                const SizedBox(height: 36.0),
                GestureDetector(
                  onTap: () {
                    isSelected = !isSelected;
                    setState(() {});
                  },
                  child: Container(
                    color: EMPTY_COLOR,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: PRIMARY_COLOR,
                                size: 32.0,
                              )
                            : const Icon(
                                Icons.circle_outlined,
                                size: 32.0,
                              ),
                        const SizedBox(width: 16.0),
                        const Text(
                          '위 사실을 모두 확인 하였습니다.',
                          style: bodyBoldTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: isSelected
                  ? () {
                      // TODO: 회원탈퇴 로직:
                      // TODO: (로그아웃) UserModel current = null, LocalStorage.clearAll()
                      // TODO: (회원탈퇴 요청) API Request
                      // TODO: 첫 화면으로 이동
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteNames.onBoarding,
                        (route) => false,
                      );
                    }
                  : null,
              style: defaultButtonStyle,
              child: const Text('회원 탈퇴하기'),
            ),
          ],
        ),
      ),
    );
  }
}
