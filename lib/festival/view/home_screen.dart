import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_drop_down_button.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/data.dart';
import 'package:true_counter/common/variable/data_dummy.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/component/custom_festival_card.dart';
import 'package:true_counter/festival/model/festival_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = locations.first;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '트루카운터',
        action: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
              size: 32.0,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.notification,
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 32.0,
            ),
          )
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      '오늘 행사',
                      style: headTitleTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: 180.0,
                    child: CustomDropDownButton(
                      dropdownList: locationData,
                      defaultValue: location,
                      onChanged: (String? value) {
                        if (value != null) {
                          location = value;
                          setState(() {});
                        }
                      },
                      menuMaxHeight: 465.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              CustomListView(
                festivals: festivalListData,
                emptyMessage: '오늘의 행사는\n존재하지 않습니다',
              ),
              const Divider(
                height: 120.0,
                color: DARK_GREY_COLOR,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '종료된 행사 (최근 10개)',
                  style: headTitleTextStyle,
                ),
              ),
              const SizedBox(height: 24.0),
              CustomListView(
                festivals: festivalListData,
                emptyMessage: '최근 종료된 행사가\n존재하지 않습니다',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<FestivalModel> festivals;
  final String emptyMessage;

  const CustomListView({
    Key? key,
    required this.festivals,
    required this.emptyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return festivals.isEmpty
        ? SizedBox(
            height: 100,
            child: Center(
              child: Text(
                emptyMessage,
                style: bodyTitleBoldTextStyle.copyWith(
                  color: DARK_GREY_COLOR,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: festivals.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16.0);
            },
            itemBuilder: (BuildContext context, int index) {
              return CustomFestivalCard(
                festivalModel: festivals[index],
              );
            },
          );
  }
}
