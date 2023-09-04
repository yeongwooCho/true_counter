import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BARRIER_COLOR,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 80,
          color: Colors.white,
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR,
                    )),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "잠시만 기다려 주세요",
                  style: descriptionTextStyle,
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
