import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/repository/local_storage.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/show_cupertino_alert.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/model/token_model.dart';
import 'package:true_counter/user/model/user_model.dart';
import 'package:true_counter/user/repository/user_repository.dart';
import 'package:true_counter/user/repository/user_repository_interface.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  UserRepositoryInterface _userRepository = UserRepository();

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
                  style: headTitleTextStyle,
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
                      showAlert(
                        context: context,
                        titleWidget: const Text('회원 탈퇴 하시겠습니까?'),
                        contentWidget: const Text('회원님의 개인 정보는 모두 삭제됩니다.'),
                        completeText: '확인',
                        completeFunction: () async {
                          final bool isSuccess = await _userRepository.withdraw();
                          if(isSuccess) {
                            await LocalStorage.clearAll();
                            UserModel.current = null;
                            TokenModel.instance = null;

                            Navigator.of(context).pushNamedAndRemoveUntil(
                              RouteNames.onBoarding,
                                  (route) => false,
                            );
                          } else {
                            showCustomToast(context, msg: "현재 탈퇴할 수 없는 회원입니다.");
                          }
                        },
                        cancelText: '취소',
                        cancelFunction: () {
                          Navigator.pop(context);
                        },
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
