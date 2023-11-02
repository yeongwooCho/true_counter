import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/common/component/custom_drop_down_button.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/component/custom_festival_card.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = homeLocation.first;
  bool isLoading = false;

  void setLoading({required bool isLoading}) {
    this.isLoading = isLoading;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FestivalProvider>();
    final festivals = provider.cacheList['total'] ?? [];

    return DefaultLayout(
      isLoading: provider.cacheList['total'] == null || isLoading,
      appbar: DefaultAppBar(
        title: '트루카운터',
        action: [
          // IconButton(
          //   onPressed: () {
          //     // TODO: 스토어 공유 연결
          //   },
          //   icon: const Icon(
          //     Icons.share_outlined,
          //     size: 32.0,
          //   ),
          // ),
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
                      dropdownList: homeLocation,
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
                festivals: festivals.where((element) {
                  if (location == '전체') {
                    return element.startAt.isBefore(now) &&
                        element.endAt.isAfter(now);
                  } else {
                    return element.region == location &&
                        element.startAt.isBefore(now) &&
                        element.endAt.isAfter(now);
                  }
                }).toList(),
                emptyMessage: '오늘의 행사는\n존재하지 않습니다',
                setLoading: setLoading,
                parentContext: context,
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
                festivals: festivals.where((element) {
                  return element.startAt.isBefore(now) &&
                      element.endAt.isBefore(now);
                }).toList(),
                emptyMessage: '최근 종료된 행사가\n존재하지 않습니다',
                setLoading: setLoading,
                parentContext: context,
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
  final void Function({required bool isLoading}) setLoading;

  final BuildContext parentContext;

  const CustomListView({
    Key? key,
    required this.festivals,
    required this.emptyMessage,
    required this.setLoading,
    required this.parentContext,
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
