import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/repository/local_storage.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/util/show_cupertino_alert.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/model/user_model.dart';

class SettingsScreen extends StatelessWidget {
  final UserModel userModel;

  const SettingsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: '설정'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '계정 정보',
                    style: headTitleTextStyle,
                  ),
                  const SizedBox(height: 24.0),
                  renderDescriptionRow(
                    title: '이메일',
                    description: userModel.email,
                  ),
                  renderDescriptionRow(
                    title: '닉네임',
                    description: userModel.nickname,
                  ),
                  renderDescriptionRow(
                    title: '연락처',
                    description: userModel.phone,
                  ),
                  renderDescriptionRow(
                    title: '성별',
                    description: userModel.gender ? '남자' : '여자',
                  ),
                  renderDescriptionRow(
                    title: '생년월일',
                    description: convertDateTimeToDateString(
                        datetime: userModel.birthday),
                  ),
                  renderDescriptionRow(
                    title: '지역',
                    description: userModel.region,
                  ),
                ],
              ),
            ),
            Container(
              height: 10.0,
              color: LIGHT_GREY_COLOR,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '계정 관리',
                    style: headTitleTextStyle,
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      showAlert(
                        context: context,
                        titleWidget: const Text('로그아웃 하시겠습니까?'),
                        completeText: '확인',
                        completeFunction: () async {
                          await LocalStorage.clearAll();

                          Navigator.of(context).pushNamed(
                            RouteNames.onBoarding,
                          );
                        },
                        cancelText: '취소',
                        cancelFunction: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '로그아웃',
                          style: bodyMediumTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        RouteNames.withdraw,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '회원탈퇴',
                          style: bodyMediumTextStyle,
                          textAlign: TextAlign.start,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: DEFAULT_TEXT_COLOR,
                          size: 32.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderDescriptionRow({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: bodyMediumTextStyle,
          ),
          Text(
            description,
            style: descriptionTextStyle,
          ),
        ],
      ),
    );
  }
}
