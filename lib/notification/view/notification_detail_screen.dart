import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/notification/model/notification_model.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationDetailScreen({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '공지 상세보기',
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              notificationModel.title,
              style: MyTextStyle.headTitle,
            ),
            const SizedBox(height: 16.0),
            Text(
              "등록 일자: ${convertDateTimeToMinute(datetime: notificationModel.createdAt)}",
              style: MyTextStyle.bodyBold.copyWith(
                color: DARK_GREY_COLOR,
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              notificationModel.content,
              style: MyTextStyle.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
