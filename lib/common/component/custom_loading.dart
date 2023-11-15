import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomLoadingScreen extends StatelessWidget {
  final String title;

  const CustomLoadingScreen({
    Key? key,
    this.title = '잠시만 기다려 주세요.',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BARRIER_COLOR,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR,
                    )),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: MyTextStyle.descriptionRegular,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
