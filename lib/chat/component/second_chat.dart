import 'package:flutter/material.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/util/datetime.dart';

class SecondChat extends StatelessWidget {
  final ChatModel chat;

  const SecondChat({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.subdirectory_arrow_right_rounded,
          size: 20.0,
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: LIGHT_GREY_COLOR,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.nickName,
                        style: bodyTitleBoldTextStyle,
                      ),
                      Container(
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: DARK_GREY_COLOR,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.thumb_up_outlined,
                                color: WHITE_TEXT_COLOR,
                              ),
                              iconSize: 16.0,
                            ),
                            Container(
                              color: WHITE_TEXT_COLOR,
                              width: 1.0,
                              height: 16.0,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notification_important_outlined,
                                color: WHITE_TEXT_COLOR,
                              ),
                              iconSize: 16.0,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    chat.content,
                    style: bodyMediumTextStyle.copyWith(
                      color: DARK_GREY_COLOR,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    children: [
                      Text(
                        convertDateTimeToMinute(datetime: chat.createdAt),
                        style: descriptionTextStyle,
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(
                        Icons.thumb_up_outlined,
                        color: ERROR_COLOR,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        chat.chatLike.toString(),
                        style: descriptionTextStyle.copyWith(
                          color: ERROR_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
