import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_list_card.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/variable/data_dummy.dart';
import 'package:true_counter/common/view/custom_list_screen.dart';
import 'package:true_counter/festival_list/component/custom_container_button.dart';

class FestivalListScreen extends StatefulWidget {
  const FestivalListScreen({Key? key}) : super(key: key);

  @override
  State<FestivalListScreen> createState() => _FestivalListScreenState();
}

class _FestivalListScreenState extends State<FestivalListScreen> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '행사 리스트',
        action: [
          TextButton(
            onPressed: () {},
            child: const Text('행사 등록신청'),
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
                      selectedItemIndex = 2;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomListScreen(
                itemCount: festivalListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomListCard(
                    title: festivalListData[index].title,
                    description:
                        "행사 기간: ${convertDateTimeToDateString(datetime: festivalListData[index].startAt)} ~ ${convertDateTimeToDateString(datetime: festivalListData[index].endAt)}",
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   RouteNames.notificationDetail,
                      //   arguments: ScreenArguments<FestivalModel>(
                      //     data: festivalListData[index],
                      //   ),
                      // );
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
}
