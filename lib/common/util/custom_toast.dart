import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

void showCustomToast(
  context, {
  required String msg,
  Duration? toastDuration,
  Color backgroundColor = DEFAULT_TEXT_COLOR,
  Color foregroundColor = WHITE_TEXT_COLOR,
}) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: backgroundColor.withOpacity(0.8),
    ),
    child: Text(
      msg,
      style: bodyBoldTextStyle.copyWith(
        color: foregroundColor,
      ),
      textAlign: TextAlign.center,
    ),
  );

  fToast.showToast(
      child: toast,
      toastDuration: toastDuration ?? const Duration(seconds: 3),
      positionedToastBuilder: (context, child) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            child,
          ],
        );
      });
}
