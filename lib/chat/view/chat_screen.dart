import 'package:flutter/material.dart';
import 'package:true_counter/chat/component/first_chat.dart';
import 'package:true_counter/chat/component/second_chat.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';

class ChatScreen extends StatelessWidget {
  final List<ChatModel> chats;

  const ChatScreen({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chats.isEmpty
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Text(
              '첫 댓글을 작성 해보세요!',
              style: bodyMediumTextStyle.copyWith(
                color: DARK_GREY_COLOR,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: chats.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16.0);
            },
            itemBuilder: (BuildContext context, int index) {
              if (chats[index].parentChatId == null) {
                return FirstChat(
                  chat: chats[index],
                );
              } else {
                return SecondChat(
                  chat: chats[index],
                );
              }
            },
          );
  }
}
