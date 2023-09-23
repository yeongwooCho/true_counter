import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
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
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '주최자/단체 이름',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '주최자/단체 연락처',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
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
              CustomTextFormField(
                title: '행사 기간',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: '문의/전달사항(선택사항)',
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
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

  // Future<void> onTapDaumAddress({
  //   required BuildContext context,
  // }) async {
  //   KopoModel model = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //       builder: (context) => RemediKopo(),
  //     ),
  //   );
  //   zonecode = model.zonecode;
  //   address = model.address;
  //   addressType = model.addressType;
  //   userSelectedType = model.userSelectedType;
  //   roadAddress = model.roadAddress;
  //   jibunAddress = model.jibunAddress;
  // }

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
      children: [
        CustomContainerButton(
          title: '무제한',
          isSelected: selectedItemIndex == 0,
          onTap: () {
            selectedItemIndex = 0;
            widget.onTapRadius(radius: 0);

            setState(() {});
          },
          textPadding: 8.0,
          borderColor: DARK_GREY_COLOR,
          disableBackgroundColor: WHITE_TEXT_COLOR,
          disableForegroundColor: DARK_GREY_COLOR,
          width: buttonWidth,
        ),
        CustomContainerButton(
          title: '2km',
          isSelected: selectedItemIndex == 1,
          onTap: () {
            selectedItemIndex = 1;
            widget.onTapRadius(radius: 2);
            setState(() {});
          },
          textPadding: 8.0,
          borderColor: DARK_GREY_COLOR,
          disableBackgroundColor: WHITE_TEXT_COLOR,
          disableForegroundColor: DARK_GREY_COLOR,
          width: buttonWidth,
        ),
        CustomContainerButton(
          title: '1km',
          isSelected: selectedItemIndex == 2,
          onTap: () {
            selectedItemIndex = 2;
            widget.onTapRadius(radius: 1);
            setState(() {});
          },
          textPadding: 8.0,
          borderColor: DARK_GREY_COLOR,
          disableBackgroundColor: WHITE_TEXT_COLOR,
          disableForegroundColor: DARK_GREY_COLOR,
          width: buttonWidth,
        ),
        CustomContainerButton(
          title: '500m',
          isSelected: selectedItemIndex == 3,
          onTap: () {
            selectedItemIndex = 3;
            widget.onTapRadius(radius: 0.5);
            setState(() {});
          },
          textPadding: 8.0,
          borderColor: DARK_GREY_COLOR,
          disableBackgroundColor: WHITE_TEXT_COLOR,
          disableForegroundColor: DARK_GREY_COLOR,
          width: buttonWidth,
        ),
      ],
    );
  }
}
