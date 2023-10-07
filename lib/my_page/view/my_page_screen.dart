import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/user/model/user_model.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '마이페이지',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  UserModel.current == null ||
                          UserModel.current?.isDummy == true
                      ? '로그인 후 이용해주세요.'
                      : UserModel.current!.nickname,
                  style: headTitleTextStyle,
                ),
                IconButton(
                  onPressed: UserModel.current == null ||
                          UserModel.current?.isDummy == true
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(
                            RouteNames.settings,
                            arguments:
                                ScreenArguments(data: UserModel.current!),
                          );
                        },
                  icon: const Icon(
                    Icons.settings_outlined,
                    size: 32.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            renderCustomButton(
              title: '트루카운터 소개 및 후원하기',
              iconName: Icons.volunteer_activism_outlined,
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteNames.introduce,
                );
              },
            ),
            const SizedBox(height: 16.0),
            renderCustomButton(
              title: '나의 참여정보',
              iconName: Icons.description_outlined,
              onTap: (UserModel.current != null && !(UserModel.current!.isDummy))? () {
                Navigator.of(context).pushNamed(
                  RouteNames.myParticipation,
                );
              } : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget renderCustomButton({
    required String title,
    required IconData iconName,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: EMPTY_COLOR,
          border: Border.all(
            width: 1.0,
            color: DARK_GREY_COLOR,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Row(
            children: [
              Icon(
                iconName,
                size: 32.0,
              ),
              const SizedBox(width: 16.0),
              Text(
                title,
                style: bodyMediumTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
