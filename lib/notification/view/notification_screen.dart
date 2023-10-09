import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/common/component/custom_list_card.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/common/model/screen_arguments.dart';
import 'package:true_counter/common/util/datetime.dart';
import 'package:true_counter/common/util/show_cupertino_alert.dart';
import 'package:true_counter/common/variable/routes.dart';
import 'package:true_counter/common/view/custom_list_screen.dart';
import 'package:true_counter/my_settings.dart';
import 'package:true_counter/notification/model/notification_model.dart';
import 'package:true_counter/notification/provider/notification_provider.dart';
import 'package:true_counter/user/model/user_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    final notifications =
        provider.cache.isNotEmpty ? provider.cache.values.first : [];

    return DefaultLayout(
      appbar: DefaultAppBar(
        title: '공지사항 / 알림',
        action: UserModel.current != null &&
                adminEmails.contains(UserModel.current!.email)
            ? [
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(RouteNames.notificationEdit);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: DARK_GREY_COLOR,
                  ),
                )
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: notifications.isEmpty
            ? Center(
                child: Text(
                  '현재 등록된 공지가\n존재하지 않습니다.',
                  style: bodyMediumTextStyle.copyWith(color: DARK_GREY_COLOR),
                  textAlign: TextAlign.center,
                ),
              )
            : CustomListScreen(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onLongPress: () {
                      if (UserModel.current != null &&
                          adminEmails.contains(UserModel.current!.email)) {
                        showAlert(
                          context: context,
                          titleWidget: const Text('해당 공지를 삭제하시겠습니까?'),
                          completeText: '확인',
                          completeFunction: () {
                            provider.deleteNotification(
                              id: notifications[index].id,
                              title: notifications[index].title,
                              content: notifications[index].content,
                            );
                            Navigator.pop(context);
                          },
                          cancelText: "취소",
                          cancelFunction: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                    child: CustomListCard(
                      title: notifications[index].title,
                      description:
                          "등록일자: ${convertDateTimeToMinute(datetime: notifications[index].createdAt)}",
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RouteNames.notificationDetail,
                          arguments: ScreenArguments<NotificationModel>(
                            data: notifications[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
