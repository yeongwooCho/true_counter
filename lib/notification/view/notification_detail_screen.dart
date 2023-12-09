import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
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
    List<String> contents = notificationModel.content.split('\n').toList();

    return DefaultLayout(
      appbar: const DefaultAppBar(
        title: '공지 상세보기',
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List<Widget>.generate(
                  contents.length,
                  (index) => contents[index].contains('https://')
                      ? RichText(
                          text: TextSpan(
                            text: contents[index],
                            style: MyTextStyle.bodyMedium.copyWith(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchBrowserTab(
                                  Uri.parse(
                                    contents[index],
                                  ),
                                );
                              },
                          ),
                        )
                      : SelectableText(
                          contents[index],
                          style: MyTextStyle.bodyMedium,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
