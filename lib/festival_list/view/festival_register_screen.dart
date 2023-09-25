import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/festival_list/component/custom_container_button.dart';

class FestivalRegisterScreen extends StatefulWidget {
  const FestivalRegisterScreen({Key? key}) : super(key: key);

  @override
  State<FestivalRegisterScreen> createState() => _FestivalRegisterScreenState();
}

class _FestivalRegisterScreenState extends State<FestivalRegisterScreen> {
  // 행사장 위치
  String? zonecode;
  String? address;
  String? addressType;
  String? userSelectedType;
  String? roadAddress;
  String? jibunAddress;

  // 참여 가능한 반경
  double radius = 0;

  // 행사 기간
  DateTime? startAt;
  DateTime? endAt;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '행사 등록 신청',
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderDescriptionContainer(),
              const SizedBox(height: 32.0),
              CustomTextFormField(
                title: '행사명',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                hintText: '20자 이내',
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '주최자/단체 이름',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                hintText: '20자 이내',
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '주최자/단체 연락처',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                hintText: '- 없이 입력',
              ),
              const SizedBox(height: 24.0),
              const Text(
                '행사장 위치',
                style: bodyTitleBoldTextStyle,
              ),
              const SizedBox(height: 8.0),
              (zonecode != null ||
                      address != null ||
                      addressType != null ||
                      userSelectedType != null ||
                      roadAddress != null ||
                      jibunAddress != null)
                  ? Container(
                      color: Colors.red,
                      child: Column(
                        children: [
                          Text(zonecode!),
                          Text(address!),
                          Text(addressType!),
                          Text(userSelectedType!),
                          Text(roadAddress!),
                          Text(jibunAddress!),
                        ],
                      ),
                    )
                  : CustomContainerButton(
                      title: '주소 선택',
                      isSelected: true,
                      onTap: onTapKakaoAddress,
                      borderColor: DARK_GREY_COLOR,
                      disableBackgroundColor: WHITE_TEXT_COLOR,
                      disableForegroundColor: DARK_GREY_COLOR,
                      textPadding: 12.0,
                    ),
              const SizedBox(height: 24.0),
              const Text(
                '참여 가능한 반경',
                style: bodyTitleBoldTextStyle,
              ),
              const SizedBox(height: 8.0),
              _RadiusScope(
                onTapRadius: onTapRadius,
              ),
              const SizedBox(height: 24.0),
              _FestivalDuration(
                callBackData: ({
                  required DateTime date,
                  required bool isStart,
                }) {
                  if (isStart) {
                    startAt = date;
                  } else {
                    endAt = date;
                  }
                },
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                child: CustomTextFormField(
                  title: '문의/전달사항(선택사항)',
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                  contentPaddingVertival: 12.0,
                  maxLines: 10,
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: defaultButtonStyle,
                child: const Text('등록 신청하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderDescriptionContainer() {
    return Container(
      decoration: BoxDecoration(
        color: LIGHT_GREY_COLOR,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '◦ 행사 등록 신청 전에 행사리스트에서 동일한 행사가 있는지 먼저 확인해주세요.',
              style: descriptionTextStyle,
            ),
            SizedBox(height: 8.0),
            Text(
              '◦ 행사 등록 신청은 무분별한 중복 등록 방지를 위한 과정입니다.',
              style: descriptionTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  void onTapRadius({
    required double radius,
  }) {
    this.radius = radius;
  }

  Future<void> onTapKakaoAddress() async {
    // await onTapDaumAddress(context: context);

    Kpostal result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          appBar: DefaultAppBar(title: '주소 검색'),
        ),
      ),
    );
    //   zonecode = model.zonecode;
    //   address = model.address;
    //   addressType = model.addressType;
    //   userSelectedType = model.userSelectedType;
    //   roadAddress = model.roadAddress;
    //   jibunAddress = model.jibunAddress;
    print(result.address);

    setState(() {});
  }
}

class _RadiusScope extends StatefulWidget {
  final void Function({
    required double radius,
  }) onTapRadius;

  const _RadiusScope({
    Key? key,
    required this.onTapRadius,
  }) : super(key: key);

  @override
  State<_RadiusScope> createState() => _RadiusScopeState();
}

class _RadiusScopeState extends State<_RadiusScope> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double buttonWidth = (width - 32 - 24) / 4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(
        4,
        (index) {
          late String title;
          late double radius;

          switch (index) {
            case 0:
              title = '무제한';
              radius = 0.0;
            case 1:
              title = '500m';
              radius = 0.5;
            case 2:
              title = '1km';
              radius = 1.0;
            case 3:
              title = '2km';
              radius = 2.0;
            default:
              title = '';
              radius = -1.0;
          }

          return CustomContainerButton(
            title: title,
            isSelected: selectedItemIndex == index,
            onTap: () {
              selectedItemIndex = index;
              widget.onTapRadius(radius: radius);
              setState(() {});
            },
            textPadding: 8.0,
            borderColor: DARK_GREY_COLOR,
            disableBackgroundColor: WHITE_TEXT_COLOR,
            disableForegroundColor: DARK_GREY_COLOR,
            width: buttonWidth,
          );
        },
      ),
    );
  }
}

class _FestivalDuration extends StatefulWidget {
  final void Function({
    required DateTime date,
    required bool isStart,
  })? callBackData;

  const _FestivalDuration({
    Key? key,
    required this.callBackData,
  }) : super(key: key);

  @override
  State<_FestivalDuration> createState() => _FestivalDurationState();
}

class _FestivalDurationState extends State<_FestivalDuration> {
  // 행사 기간
  DateTime? startAt;
  DateTime? endAt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '행사 기간',
          style: bodyTitleBoldTextStyle,
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onDatePressed(
                    isStart: true,
                  );
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: startAt == null
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '행사 시작 시간',
                                style: descriptionGreyTextStyle,
                              ),
                              SizedBox(width: 4.0),
                              Icon(
                                Icons.expand_more_rounded,
                                color: DARK_GREY_COLOR,
                              ),
                            ],
                          )
                        : Text(
                            convertDateTimeToMinute(datetime: startAt!),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('~'),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onDatePressed(
                    isStart: false,
                  );
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: endAt == null
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '행사 끝 시간',
                                style: descriptionGreyTextStyle,
                              ),
                              SizedBox(width: 4.0),
                              Icon(
                                Icons.expand_more_rounded,
                                color: DARK_GREY_COLOR,
                              ),
                            ],
                          )
                        : Text(
                            convertDateTimeToMinute(datetime: endAt!),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void onDatePressed({
    required bool isStart,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 240.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
              color: BACKGROUND_COLOR,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Expanded(
                child: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.ymd,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (DateTime value) {
                    if (isStart) {
                      startAt = value;
                    } else {
                      endAt = value;
                    }
                    if (widget.callBackData != null) {
                      widget.callBackData!(
                        date: value,
                        isStart: isStart,
                      );
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
