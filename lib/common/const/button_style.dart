import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: WHITE_TEXT_COLOR,
  backgroundColor: PRIMARY_COLOR,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
  minimumSize: const Size(100, 50),
  textStyle: bodyBoldWhiteTextStyle,
);

ButtonStyle deactivateButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: DARK_GREY_COLOR,
  backgroundColor: LIGHT_GREY_COLOR,
);

ButtonStyle secondButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: DEFAULT_TEXT_COLOR,
  backgroundColor: WHITE_TEXT_COLOR,
  side: BorderSide(
    width: 2.0,
    color: DEFAULT_TEXT_COLOR,
  ),
);
