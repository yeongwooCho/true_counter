import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/model/festival_model.dart';

class FestivalDetailScreen extends StatelessWidget {
  final FestivalModel festivalModel;

  const FestivalDetailScreen({
    Key? key,
    required this.festivalModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: '행사 상세정보'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderFestivalDescription(context: context),
              const SizedBox(height: 48.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: DEFAULT_TEXT_COLOR,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 300.0,
              ),
              Text(festivalModel.region),
              Text('${festivalModel.radius}'),
              Text('${festivalModel.cumulativeParticipantCount}'),
              Text('${festivalModel.longitude}'),
              Text('${festivalModel.latitude}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderFestivalDescription({
    required BuildContext context,
  }) {
    String start = convertDateTimeToDateString(datetime: festivalModel.startAt);
    String end = convertDateTimeToDateString(datetime: festivalModel.endAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _renderDescriptionRow(
          title: '행사명',
          description: festivalModel.title,
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '주최자/단체',
          description: festivalModel.applicant,
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '행사 장소',
          description: festivalModel.address,
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              RouteNames.kakaoMap,
            );
          },
          style: secondButtonStyle,
          child: const Text('지도 보기'),
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '행사 기간',
          description: "$start ~ $end",
        ),
        const SizedBox(height: 24.0),
        _renderDescriptionRow(
          title: '문의/전달사항',
          description: festivalModel.message,
        ),
      ],
    );
  }

  Widget _renderDescriptionRow({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: bodyTitleBoldTextStyle,
        ),
        const SizedBox(height: 4.0),
        Text(
          description,
          style: bodyMediumTextStyle,
        ),
      ],
    );
  }
}
