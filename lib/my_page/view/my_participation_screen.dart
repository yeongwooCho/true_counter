import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_list_card.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/variable/data_dummy.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/common/view/custom_list_screen.dart';
import 'package:true_counter/festival/model/festival_model.dart';

class MyParticipationScreen extends StatelessWidget {
  const MyParticipationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: '나의 참여정보'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomListScreen(
          itemCount: myFestivalListData.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListCard(
              title: myFestivalListData[index].title,

              // TODO: 참여일자로 데이터 넣어야 함
              description:
                  "참여 일자: ${myFestivalListData[index].userParticipationAt == null ? 'null' : convertDateTimeToDateString(
                      datetime: myFestivalListData[index].userParticipationAt!,
                    )}",
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteNames.festivalDetail,
                  arguments: ScreenArguments<FestivalModel>(
                    data: myFestivalListData[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
