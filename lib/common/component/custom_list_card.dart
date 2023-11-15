import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class CustomListCard extends StatelessWidget {
  final String title;
  final String description;
  final void Function()? onTap;

  const CustomListCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: EMPTY_COLOR,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MyTextStyle.bodyBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      description,
                      style: MyTextStyle.descriptionRegular.copyWith(
                        color: DARK_GREY_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              const Icon(
                Icons.chevron_right,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
