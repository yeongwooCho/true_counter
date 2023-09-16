import 'package:flutter/material.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
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
              style: titleTextStyle,
            ),
            const SizedBox(height: 16.0),
            Text(
              "등록 일자: ${notificationModel.createdAt}",
              style: bodyBoldTextStyle.copyWith(
                color: DARK_GREY_COLOR,
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              notificationModel.description,
              style: bodyMediumTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
