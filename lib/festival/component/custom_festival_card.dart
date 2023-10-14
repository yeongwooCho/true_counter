import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/common/component/custom_loading.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/data.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/money_format.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/festival/component/custom_chart.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';
import 'package:true_counter/user/model/user_model.dart';

class CustomFestivalCard extends StatelessWidget {
  // Widget
  // width: 343, height: 362
  final FestivalModel festivalModel;
  final bool pressable;

  const CustomFestivalCard({
    Key? key,
    required this.festivalModel,
    this.pressable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FestivalProvider festivalProvider = context.read<FestivalProvider>();

    return GestureDetector(
      onTap: () {
        if (pressable) {
          Navigator.of(context).pushNamed(
            RouteNames.festivalDetail,
            arguments: ScreenArguments<FestivalModel>(
              data: festivalModel,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: DARK_GREY_COLOR,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: festivalModel.startAt.isAfter(now)
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '예정된 행사 입니다.',
                    style: bodyTitleBoldTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "[${festivalModel.region}] ${festivalModel.title}",
                            style: bodyTitleBoldTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: isActiveButton(festival: festivalModel)
                              ? (UserModel.current == null ||
                                      (UserModel.current!.isDummy))
                                  ? () {
                                      showCustomToast(context,
                                          msg: "로그인 후 이용 가능합니다.");
                                    }
                                  : () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            icon: const Text(
                                              '행사 참여하기',
                                              style: bodyTitleBoldTextStyle,
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  '행사명',
                                                  textAlign: TextAlign.start,
                                                  style: bodyBoldTextStyle,
                                                ),
                                                const SizedBox(height: 4.0),
                                                Text(
                                                  '[${festivalModel.region}] ${festivalModel.title}',
                                                  textAlign: TextAlign.start,
                                                  style: descriptionTextStyle,
                                                ),
                                              ],
                                            ),
                                            content: Text(
                                              '행사 참여자로 카운팅 되기 위해서는 회원님이 행사장 반경 ${convertRadiusToString(radius: festivalModel.radius)} 안에 있어야 합니다.',
                                              style: descriptionTextStyle,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  double tempRadius =
                                                      festivalModel.radius;
                                                  print(tempRadius);

                                                  if (tempRadius != 0.5 &&
                                                      tempRadius != 1.0 &&
                                                      tempRadius != 2.0) {
                                                    festivalProvider
                                                        .participateFestival(
                                                            festivalId:
                                                                festivalModel
                                                                    .id);
                                                    showCustomToast(context,
                                                        msg:
                                                            "행사 참여가 완료 되었습니다.");
                                                  } else {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const CustomLoadingScreen(
                                                          title:
                                                              "위치 정보를 받아오고 있습니다.",
                                                        );
                                                      },
                                                    );
                                                    await _determinePermission();

                                                    Position position =
                                                        await Geolocator
                                                            .getCurrentPosition(
                                                      desiredAccuracy:
                                                          LocationAccuracy.high,
                                                    );
                                                    Navigator.of(context).pop();

                                                    final double distance =
                                                        Geolocator
                                                            .distanceBetween(
                                                      festivalModel.latitude,
                                                      festivalModel.longitude,
                                                      position.latitude,
                                                      position.longitude,
                                                    );

                                                    if (distance <
                                                        (festivalModel.radius *
                                                            1000)) {
                                                      festivalProvider
                                                          .participateFestival(
                                                              festivalId:
                                                                  festivalModel
                                                                      .id);
                                                      showCustomToast(
                                                        context,
                                                        msg: "행사 참여가 완료 되었습니다.",
                                                      );
                                                    } else {
                                                      showCustomToast(
                                                        context,
                                                        msg:
                                                            "참여 가능 반경 안에서 참여해 주세요.",
                                                      );
                                                    }
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('참여하기'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('취소'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                              : null,
                          style: festivalParticipateButtonStyle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 4.0,
                            ),
                            child:
                                getParticipateStatus(festival: festivalModel),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          '누적인원: ',
                          style: descriptionGreyTextStyle.copyWith(
                              color: PRIMARY_COLOR
                          ),
                        ),
                        Text(
                          '${convertIntToMoneyString(number: festivalModel.cumulativeParticipantCount)} 명',
                          style: descriptionGreyTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '참여반경: ',
                          style: descriptionGreyTextStyle.copyWith(
                            color: PRIMARY_COLOR,
                          ),

                        ),
                        Text(
                          '${convertRadiusToString(
                            radius: festivalModel.radius,
                          )}',
                          style: descriptionGreyTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: PRIMARY_COLOR
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    CustomChart(
                      festivalModel: festivalModel,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget getParticipateStatus({required FestivalModel festival}) {
    if (festival.endAt.isBefore(now)) {
      return const Text('행사\n종료');
    } else if (festival.startAt.isAfter(now)) {
      return const Text('행사\n예정');
    } else if (festival.isParticipated) {
      return const Text('참여\n완료');
    } else {
      return const Text('참여\n체크');
    }
  }

  bool isActiveButton({required FestivalModel festival}) {
    if (festival.endAt.isBefore(now)) {
      return false;
    } else if (festival.startAt.isAfter(now)) {
      return false;
    } else if (festival.isParticipated) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> _determinePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value(false);
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.value(false);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  String convertRadiusToString({
    required double radius,
  }) {
    switch (radius) {
      case 0.5:
        return '500m';
      case 1:
        return '1km';
      case 2:
        return '2km';
      default:
        return '무제한';
    }
  }
}
