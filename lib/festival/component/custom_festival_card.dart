import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomFestivalCard extends StatelessWidget {
  final String title;
  final int cumulativeParticipant;
  final double radius;

  const CustomFestivalCard({
    Key? key,
    required this.title,
    required this.cumulativeParticipant,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: DARK_GREY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: bodyTitleBoldTextStyle,
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {},
                  style: festivalParticipateButton,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 4.0,
                    ),
                    child: Text('참여\n체크'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              '누적 참여자 수: $cumulativeParticipant 명',
              style: descriptionGreyTextStyle,
            ),
            Text(
              '참여 가능 반경: $radius',
              style: descriptionGreyTextStyle,
            ),
            const SizedBox(height: 16.0),
            Container(
              color: Colors.greenAccent,
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}
