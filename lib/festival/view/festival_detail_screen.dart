import 'package:flutter/material.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(festivalModel.id),
            Text(festivalModel.title),
            Text(festivalModel.address),
            Text(festivalModel.message),
            Text(festivalModel.applicantPhone),
            Text(festivalModel.applicant),
            Text(festivalModel.region),
            Text('${festivalModel.radius}'),
            Text('${festivalModel.startAt}'),
            Text('${festivalModel.endAt}'),
            Text('${festivalModel.cumulativeParticipantCount}'),
            Text('${festivalModel.longitude}'),
            Text('${festivalModel.latitude}'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteNames.kakaoMap,
                  );
                },
                style: defaultButtonStyle,
                child: const Text('지도로 이동'))
          ],
        ),
      ),
    );
  }
}
