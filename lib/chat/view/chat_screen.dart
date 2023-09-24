import 'package:flutter/material.dart';
import 'package:true_counter/chat/component/first_chat.dart';
import 'package:true_counter/chat/component/second_chat.dart';
import 'package:true_counter/chat/model/chat_model.dart';

class ChatScreen extends StatelessWidget {
  final List<ChatModel> chats;

  const ChatScreen({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chats.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16.0);
      },
      itemBuilder: (BuildContext context, int index) {
        if (chats[index].parentChatId == null) {
          return FirstChat(chat: chats[index]);
        } else {
          return SecondChat(chat: chats[index]);
        }
      },
    );
  }
}
