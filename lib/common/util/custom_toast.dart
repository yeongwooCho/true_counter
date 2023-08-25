import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

void showCustomToast(context, text) {
  final fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: ERROR_COLOR,
    ),
    child: Text(
      text,
      style: bodyBoldWhiteTextStyle,
    ),
  );

  fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 1),
      positionedToastBuilder: (context, child) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            child,
          ],
        );
      });
}
