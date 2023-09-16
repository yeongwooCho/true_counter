import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/notification/model/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCard({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteNames.notificationDetail,
          arguments: ScreenArguments<NotificationModel>(
            data: notificationModel,
          ),
        );
      },
      child: Container(
        color: EMPTY_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationModel.title,
                      style: bodyBoldTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "등록일자: ${notificationModel.createdAt}",
                      style: descriptionGreyTextStyle,
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
