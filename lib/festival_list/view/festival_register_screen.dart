import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/festival/repository/festival_repository.dart';
import 'package:true_counter/festival_list/component/custom_container_button.dart';

class FestivalRegisterScreen extends StatefulWidget {
  const FestivalRegisterScreen({Key? key}) : super(key: key);

  @override
  State<FestivalRegisterScreen> createState() => _FestivalRegisterScreenState();
}

class _FestivalRegisterScreenState extends State<FestivalRegisterScreen> {
  final FestivalRepository _festivalRepository = FestivalRepository();

  String? festivalTitle; // 행사명
  String? applicant; // 주최자 이름 혹은 단체
  String? applicantPhone; // 주최자 전화번호

  double radius = 0; // 참여 가능한 반경
  DateTime? startAt; // 행사 시작 시간
  DateTime? endAt; // 행사 끝 시간
  String? message;

  // 행사장 위치
  TextEditingController? addressController;
  String? postCode;
  String? address;
  String? roadAddress;
  String? jibunAddress;
  String? region;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();

    addressController = TextEditingController();
  }

  @override
  void dispose() {
    addressController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(festivalTitle);
    print(festivalTitle.runtimeType);
    print(applicant);
    print(applicant.runtimeType);
    print(applicantPhone);
    print(applicantPhone.runtimeType);

    print(startAt);
    print(startAt.runtimeType);
    print(endAt);
    print(endAt.runtimeType);
    print(message);
    print(message.runtimeType);
    print(address);
    print(address.runtimeType);

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
                onChanged: (String? value) {
                  festivalTitle = value;
                  setState(() {});
                },
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                maxLength: 20,
                hintText: ' 20자 이내',
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                title: '주최자/단체 이름',
                onChanged: (String? value) {
                  applicant = value;
                  setState(() {});
                },
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                maxLength: 20,
                hintText: ' 20자 이내',
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                title: '주최자/단체 연락처',
                onChanged: (String? value) {
                  applicantPhone = value;
                  setState(() {});
                },
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                maxLength: 11,
                hintText: ' - 없이 입력',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 8.0),
              const Text(
                '행사장 위치',
                style: MyTextStyle.bodyTitleBold,
              ),
              const SizedBox(height: 8.0),
              CustomTextFormField(
                controller: addressController,
                buttonText: '주소검색',
                onPressedButton: onTapKakaoAddress,
                enabled: false,
                maxLines: 2,
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              const Text(
                '참여 가능한 반경',
                style: MyTextStyle.bodyTitleBold,
              ),
              const SizedBox(height: 8.0),
              _RadiusScope(
                onTapRadius: onTapRadius,
              ),
              const SizedBox(height: 24.0),
              _FestivalDuration(
                parentContext: context,
                callBackData: ({
                  required DateTime date,
                  required bool isStart,
                }) {
                  if (isStart) {
                    startAt = date;
                  } else {
                    endAt = date;
                  }
                  setState(() {});
                },
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                child: CustomTextFormField(
                  title: '행사정보/전달사항',
                  hintText: '500자 이내',
                  onChanged: (String? value) {
                    message = value;
                    setState(() {});
                  },
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  contentPaddingVertical: 12.0,
                  maxLines: 10,
                  maxLength: 500,
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: festivalTitle == null ||
                        applicant == null ||
                        applicantPhone == null ||
                        address == null ||
                        region == null ||
                        startAt == null ||
                        endAt == null ||
                        festivalTitle!.isEmpty ||
                        applicant!.isEmpty ||
                        applicantPhone!.isEmpty ||
                        address!.isEmpty ||
                        region!.isEmpty
                    ? null
                    : () async {
                        if (endAt!.difference(startAt!).isNegative) {
                          showCustomToast(
                            context,
                            msg: '행사 기간을\n올바르게 수정해주세요.',
                          );
                          return;
                        }

                        await _festivalRepository.createFestival(
                          title: festivalTitle!,
                          applicant: applicant!,
                          applicantPhone: applicantPhone!,
                          message: message ?? "",
                          latitude: latitude,
                          longitude: longitude,
                          radius: radius,
                          address: address!,
                          region: region!,
                          startAt: startAt!,
                          endAt: endAt!,
                          isValid: true,
                        );

                        showCustomToast(
                          context,
                          msg: "행사 등록 신청이\n완료되었습니다.",
                        );
                        Future.delayed(const Duration(seconds: 2));
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
              style: MyTextStyle.descriptionRegular,
            ),
            SizedBox(height: 8.0),
            Text(
              '◦ 행사 등록 신청은 무분별한 중복 등록 방지를 위한 과정입니다.',
              style: MyTextStyle.descriptionRegular,
            ),
          ],
        ),
      ),
    );
  }

  void onTapRadius({
    required double radius,
  }) {
    setState(() {
      this.radius = radius;
    });
  }

  Future<void> onTapKakaoAddress() async {
    // await onTapDaumAddress(context: context);

    Kpostal result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          appBar: const DefaultAppBar(title: '주소 검색'),
        ),
      ),
    );
    postCode = result.postCode;
    address = result.address;
    roadAddress = result.roadAddress;
    jibunAddress = result.jibunAddress;
    addressController?.text = "$address";

    region = result.sido;
    latitude = result.latitude ?? 0.0;
    longitude = result.longitude ?? 0.0;

    print('주소받기 완료');

    print(postCode);
    print(address);
    print(roadAddress);
    print(jibunAddress);
    print(region);
    print(latitude);
    print(longitude);

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
              radius = 3.0;
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
  final BuildContext parentContext;
  final void Function({
    required DateTime date,
    required bool isStart,
  })? callBackData;

  const _FestivalDuration({
    Key? key,
    required this.parentContext,
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
          style: MyTextStyle.bodyTitleBold,
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
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '행사 시작 일자',
                                style: MyTextStyle.descriptionRegular
                                    .copyWith(color: DARK_GREY_COLOR),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(
                                Icons.expand_more_rounded,
                                color: DARK_GREY_COLOR,
                              ),
                            ],
                          )
                        : Text(
                            convertDateTimeToMinute(datetime: startAt!),
                            style: MyTextStyle.descriptionRegular,
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
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
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '행사 끝 일자',
                                style: MyTextStyle.descriptionRegular.copyWith(
                                  color: DARK_GREY_COLOR,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(
                                Icons.expand_more_rounded,
                                color: DARK_GREY_COLOR,
                              ),
                            ],
                          )
                        : Text(
                            convertDateTimeToMinute(datetime: endAt!),
                            style: MyTextStyle.descriptionRegular,
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
              child: CupertinoDatePicker(
                dateOrder: DatePickerDateOrder.ymd,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime value) {
                  if (isStart) {
                    startAt = DateTime(
                      value.year,
                      value.month,
                      value.day,
                    );
                  } else {
                    endAt = DateTime(
                      value.year,
                      value.month,
                      value.day,
                      23,
                      59,
                      59,
                    );
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
        );
      },
    );
  }
}
