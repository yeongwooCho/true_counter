import 'package:flutter/material.dart';
import 'package:true_counter/common/component/custom_list_card.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/variable/data.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/common/view/custom_list_screen.dart';
import 'package:true_counter/notification/model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: const DefaultAppBar(title: '공지사항 / 알림'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomListScreen(
          itemCount: notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListCard(
              title: notifications[index].title,
              description: "등록일자: ${notifications[index].createdAt}",
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteNames.notificationDetail,
                  arguments: ScreenArguments<NotificationModel>(
                    data: notifications[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
