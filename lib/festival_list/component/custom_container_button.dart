import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomContainerButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onTap;

  const CustomContainerButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? PRIMARY_COLOR : LIGHT_GREY_COLOR,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: bodyBoldTextStyle.copyWith(
              color: isSelected ? WHITE_TEXT_COLOR : DARK_GREY_COLOR,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
