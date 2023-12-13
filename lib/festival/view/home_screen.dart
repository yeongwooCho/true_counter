import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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

  void showActionSheet({
    required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          '다운로드 링크 공유',
          style: MyTextStyle.bodyTitleBold,
        ),
        message: const Text(
          '상대방의 스마트폰에 맞는\n링크를 공유해 주세요.',
          style: MyTextStyle.bodyRegular,
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              const String packageName =
                  'com.truecounter.true_counter'; // 여기에 앱의 패키지 이름을 넣으세요.
              const String url =
                  'https://play.google.com/store/apps/details?id=$packageName';

              await Share.share(url);
              Navigator.of(context).pop();
            },
            child: const Text('안드로이드 링크 공유'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              const String appId = '6470150534'; // 여기에 앱의 App Store ID를 넣으세요.
              const String url = 'https://apps.apple.com/app/id$appId';

              await Share.share(url);
              Navigator.of(context).pop();
            },
            child: const Text('아이폰 링크 공유'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FestivalProvider>();
    final festivals = provider.cacheList['total'] ?? [];

    final List<FestivalModel> doingFestivals = festivals.where((element) {
      if (location == homeLocation.first) {
        return element.startAt.isBefore(now) &&
            element.endAt.isAfter(now);
      } else if (location == "전국") {
        return element.radius != 0.5 &&
            element.radius != 1.0 &&
            element.radius != 2.0 &&
            element.startAt.isBefore(now) &&
            element.endAt.isAfter(now);
      } else {
        return element.region == location &&
            element.startAt.isBefore(now) &&
            element.endAt.isAfter(now);
      }
    }).toList();

    final List<FestivalModel> doneFestivals = festivals.where((element) {
      return element.startAt.isBefore(now) &&
          element.endAt.isBefore(now);
    }).toList();

    doingFestivals.sort((a,b) {
      if (a.endAt.isBefore(b.endAt) || a.endAt.isAtSameMomentAs(b.endAt)) {
        return 1;
      } else {
        return -1;
      }
    });

    doneFestivals.sort((a,b) {
      if (a.endAt.isBefore(b.endAt) || a.endAt.isAtSameMomentAs(b.endAt)) {
        return 1;
      } else {
        return -1;
      }
    });

    return DefaultLayout(
      isLoading: provider.cacheList['total'] == null || isLoading,
      appbar: DefaultAppBar(
        title: '트루카운터',
        action: [
          IconButton(
            onPressed: () async {
              showActionSheet(context: context);
            },
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
                      style: MyTextStyle.headTitle,
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
                festivals: doingFestivals,
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
                  style: MyTextStyle.headTitle,
                ),
              ),
              const SizedBox(height: 24.0),
              CustomListView(
                festivals: doneFestivals,
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
                style: MyTextStyle.bodyTitleBold.copyWith(
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
