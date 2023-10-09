import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/common/component/custom_text_form_field.dart';
import 'package:true_counter/common/const/button_style.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/layout/default_appbar.dart';
import 'package:true_counter/common/layout/default_layout.dart';
import 'package:true_counter/notification/provider/notification_provider.dart';
import 'package:true_counter/notification/repository/notification_repository.dart';

class AdminNotificationEditScreen extends StatefulWidget {
  const AdminNotificationEditScreen({Key? key}) : super(key: key);

  @override
  State<AdminNotificationEditScreen> createState() =>
      _AdminNotificationEditScreenState();
}

class _AdminNotificationEditScreenState
    extends State<AdminNotificationEditScreen> {
  final NotificationRepository repository = NotificationRepository();

  String? titleText;
  String? contentText;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appbar: DefaultAppBar(title: "관리자 공지 작성"),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24.0),
              const Text(
                '관리자만 접근할 수 있습니다.\n공지할 항목을 등록해 주세요.',
                style: headTitleTextStyle,
              ),
              const SizedBox(height: 48.0),
              CustomTextFormField(
                title: "공지 제목",
                hintText: "제목을 입력해 주세요.",
                onChanged: (String? value) {
                  titleText = value;
                  setState(() {});
                },
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              CustomTextFormField(
                title: "공지 내용",
                hintText: '500자 이내',
                onChanged: (String? value) {
                  contentText = value;
                  setState(() {});
                },
                onSaved: (String? value) {},
                validator: (String? value) {
                  return null;
                },
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                contentPaddingVertical: 12.0,
                maxLines: 10,
                maxLength: 500,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: titleText != null &&
                        titleText!.isNotEmpty &&
                        contentText != null &&
                        contentText!.isNotEmpty
                    ? () async {
                        final provider = context.read<NotificationProvider>();

                        provider.createNotification(
                          title: titleText!,
                          content: contentText!,
                        );

                        Navigator.of(context).pop();
                      }
                    : null,
                style: defaultButtonStyle,
                child: const Text('공지 등록'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
