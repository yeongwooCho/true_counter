import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isCheckTotalContainer = false;
  bool isCheckPersonalInfo = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '이용약관',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 36.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '트루카운터 서비스\n이용약관에 동의해주세요.',
                  style: headTitleTextStyle,
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    if (isCheckTotalContainer == true) {
                      isCheckTotalContainer = false;
                      isCheckPersonalInfo = false;
                    } else {
                      isCheckTotalContainer = true;
                      isCheckPersonalInfo = true;
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCheckTotalContainer
                          ? PRIMARY_COLOR
                          : LIGHT_GREY_COLOR,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: 60.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 24.0,
                            color: isCheckTotalContainer
                                ? WHITE_TEXT_COLOR
                                : DEFAULT_TEXT_COLOR,
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            '전체 약관에 동의합니다.',
                            style: isCheckTotalContainer
                                ? bodyBoldWhiteTextStyle
                                : bodyTitleBoldTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                GestureDetector(
                  onTap: () {
                    isCheckPersonalInfo = !isCheckPersonalInfo;
                    checkTotal();
                    setState(() {});
                  },
                  child: CustomTerm(
                    isCheck: isCheckPersonalInfo,
                    title: '정보 제공 동의',
                    isRequired: true,
                    iconButton: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RouteNames.termsProviding,
                          );
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: DEFAULT_TEXT_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: (isCheckPersonalInfo)
                  ? () {
                      Navigator.of(context).pushNamed(RouteNames.emailRegister);
                    }
                  : null,
              style: defaultButtonStyle,
              child: const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  void checkTotal() {
    if (isCheckPersonalInfo == true) {
      isCheckTotalContainer = true;
    } else {
      isCheckTotalContainer = false;
    }
  }
}

class CustomTerm extends StatelessWidget {
  final String title;
  final bool isRequired;
  final bool isCheck;
  final Widget? iconButton;

  const CustomTerm({
    Key? key,
    required this.title,
    required this.isRequired,
    required this.isCheck,
    this.iconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = bodyBoldTextStyle.copyWith(
      fontSize: 16.0,
    );
    return Container(
      color: BACKGROUND_COLOR,
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: isCheck ? PRIMARY_COLOR : LIGHT_GREY_COLOR,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.check,
                      color: isCheck ? WHITE_TEXT_COLOR : DEFAULT_TEXT_COLOR,
                      size: 16.0,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Row(
                  children: [
                    Text(
                      title,
                      style: textStyle,
                    ),
                    const SizedBox(width: 4.0),
                    isRequired
                        ? Text('(필수)',
                            style: textStyle.copyWith(
                              color: PRIMARY_COLOR,
                            ))
                        : Text(
                            '(선택)',
                            style: textStyle.copyWith(color: DARK_GREY_COLOR),
                          ),
                  ],
                ),
              ],
            ),
            if (iconButton != null) iconButton!
          ],
        ),
      ),
    );
  }
}
