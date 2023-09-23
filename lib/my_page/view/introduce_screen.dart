import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/my_settings.dart';

class IntroduceScreen extends StatelessWidget {
  const IntroduceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: "소개 및 후원하기"),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: LIGHT_GREY_COLOR,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '트루카운터를 소개합니다.',
                        style: headTitleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        ' ◦ 트루카운터는 행사 취지에 공감하는 자발적 참여자의 실시간 인원 수를 객관적으로 보여줍니다.',
                        style: descriptionTextStyle,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        ' ◦ 트루카운터는 익명성을 기초로 운영 되며 자동생성 닉네임으로 활동하게 됩니다. ',
                        style: descriptionTextStyle,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        ' ◦ 트루카운터는 시민의 다양한 여론과 발전적 정책제안을 수렴합니다.',
                        style: descriptionTextStyle,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        ' ◦ 트루카운터는 모든 시민이 함께 할 수 있는 커뮤니티 형성에 기여합니다.',
                        style: descriptionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                decoration: BoxDecoration(
                  color: LIGHT_GREY_COLOR,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '트루카운터를 후원합니다.',
                        style: headTitleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        ' ◦ 여러분의 후원이 트루카운터를 지속 가능하게 만듭니다.',
                        style: descriptionTextStyle,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        ' ◦ 트루카운터는 왜곡 없는 정확한 데이터 제공으로 여러분의 후원에 보답하겠습니다.',
                        style: descriptionTextStyle,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        ' ◦ 월 정기 및 단기 후원 계좌',
                        style: descriptionTextStyle,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '하나은행\n22591052381107\n예금주: 최승현',
                            style: descriptionTextStyle,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              copyToClipboard(context: context);
                            },
                            style: festivalParticipateButtonStyle,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 4.0,
                              ),
                              child: Text('후원계좌\n복사하기'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void copyToClipboard({
    required BuildContext context,
  }) async {
    await Clipboard.setData(
      ClipboardData(text: BANK_ACCOUNT),
    );
  }
}
