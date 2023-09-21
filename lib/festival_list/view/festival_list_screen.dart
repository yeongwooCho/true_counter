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
import 'package:true_counter/festival_list/component/custom_container_button.dart';

class FestivalListScreen extends StatefulWidget {
  const FestivalListScreen({Key? key}) : super(key: key);

  @override
  State<FestivalListScreen> createState() => _FestivalListScreenState();
}

class _FestivalListScreenState extends State<FestivalListScreen> {
  int selectedItemIndex = 0;
  DateTime now = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<FestivalModel> beingFestivals = [];
  List<FestivalModel> toBeFestivals = [];
  List<FestivalModel> beenFestivals = [];

  @override
  void initState() {
    super.initState();

    // TODO: 이후 서버에서 가져온 값으로 로딩하도록 구현해야함.
    if (beingFestivals.isEmpty) {
      beingFestivals = festivalListData.where((festivalModel) {
        return festivalModel.startAt.isBefore(now) &&
            festivalModel.endAt.isAfter(now);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '행사 리스트',
        action: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteNames.festivalRegister,
              );
            },
            child: const Text('행사 등록 신청'),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomContainerButton(
                    title: '진행중',
                    isSelected: selectedItemIndex == 0,
                    onTap: () {
                      beingFestivals = festivalListData.where((festivalModel) {
                        return (now.isAfter(festivalModel.startAt) ||
                                now.isAtSameMomentAs(festivalModel.startAt)) &&
                            (now.isBefore(festivalModel.endAt) ||
                                now.isAtSameMomentAs(festivalModel.endAt));
                      }).toList();

                      selectedItemIndex = 0;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: CustomContainerButton(
                    title: '예정',
                    isSelected: selectedItemIndex == 1,
                    onTap: () {
                      toBeFestivals = festivalListData.where((festivalModel) {
                        return festivalModel.startAt.isAfter(now) &&
                            festivalModel.endAt.isAfter(now);
                      }).toList();

                      selectedItemIndex = 1;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: CustomContainerButton(
                    title: '종료',
                    isSelected: selectedItemIndex == 2,
                    onTap: () {
                      beenFestivals = festivalListData.where((festivalModel) {
                        return festivalModel.startAt.isBefore(now) &&
                            festivalModel.endAt.isBefore(now);
                      }).toList();

                      selectedItemIndex = 2;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomListScreen(
                itemCount:
                    selectedFestivals(selectedItemIndex: selectedItemIndex)
                        .length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomListCard(
                    title: selectedFestivals(
                            selectedItemIndex: selectedItemIndex)[index]
                        .title,
                    description:
                        "행사 기간: ${convertDateTimeToDateString(datetime: selectedFestivals(selectedItemIndex: selectedItemIndex)[index].startAt)} ~ ${convertDateTimeToDateString(datetime: selectedFestivals(selectedItemIndex: selectedItemIndex)[index].endAt)}",
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteNames.festivalDetail,
                        arguments: ScreenArguments<FestivalModel>(
                          data: selectedFestivals(
                              selectedItemIndex: selectedItemIndex)[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FestivalModel> selectedFestivals({
    required int selectedItemIndex,
  }) {
    switch (selectedItemIndex) {
      case 0:
        return beingFestivals;
      case 1:
        return toBeFestivals;
      case 2:
        return beenFestivals;
      default:
        return [];
    }
  }
}
