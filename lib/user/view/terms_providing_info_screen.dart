import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';

class TermsProvidingInfoScreen extends StatelessWidget {
  const TermsProvidingInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '정보 제공 동의 약관',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '트루 카운터 정보 제공 동의 약관',
              style: bodyMediumTextStyle.copyWith(
                color: DARK_GREY_COLOR,
              ),
            ),
            Text(
              '''
            
●  트루 카운터는 정확한 참여자 수 데이터 집계를 위하여 회원님의 휴대전화번호와 위치정보를 확인합니다.

●  ID는 회원님의 휴대전화번호 뒤 8자리이며 자동으로 불러오며 회원님 본인만 확인 가능합니다.

●  트루카운터는 자동으로 생성된 닉네임으로 활동하게 되며 익명성을 보장합니다.

●  제공된 회원님의 정보는 참여자수 파악, 여론 수렴, 정책제안, 커뮤니티 활성화 등을 위해 이용될 수 있습니다.

●  회원님의 정보는 본인 동의없이 제 3자에게 제공되지 않습니다.
            ''',
              style: bodyMediumTextStyle.copyWith(
                color: DARK_GREY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
