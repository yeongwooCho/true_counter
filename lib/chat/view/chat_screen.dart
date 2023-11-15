import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/chat/component/first_chat.dart';
import 'package:true_counter/chat/component/second_chat.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';

class ChatScreen extends StatefulWidget {
  final int festivalId;
  final List<ChatModel> chats;
  final void Function({required int parentChatId}) changeParentId;

  const ChatScreen({
    Key? key,
    required this.festivalId,
    required this.chats,
    required this.changeParentId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final festivalProvider = context.read<FestivalProvider>();

    return widget.chats.isEmpty
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Text(
              '첫 댓글을 작성 해보세요!',
              style: MyTextStyle.bodyRegular.copyWith(
                color: DARK_GREY_COLOR,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.chats.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16.0);
            },
            itemBuilder: (BuildContext context, int index) {
              if (widget.chats[index].parentChatId == null) {
                return FirstChat(
                  chat: widget.chats[index],
                  changeParentId: widget.changeParentId,
                  onTapLike: () async {
                    festivalProvider.pushLike(
                      context: context,
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );
                  },
                  onTapDeclaration: () async {
                    festivalProvider.pushDeclaration(
                      context: context,
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );
                  },
                  onTapDelete: () {
                    festivalProvider.deleteChat(
                      festivalId: widget.festivalId,
                      chatId: widget.chats[index].id,
                    );
                  },
                );
              } else {
                return SecondChat(
                  chat: widget.chats[index],
                  onTapLike: () {
                    festivalProvider.pushLike(
                      context: context,
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );
                  },
                  onTapDeclaration: () {
                    festivalProvider.pushDeclaration(
                      context: context,
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );
                  },
                  onTapDelete: () {
                    festivalProvider.deleteChat(
                      festivalId: widget.festivalId,
                      chatId: widget.chats[index].id,
                    );
                  },
                );
              }
            },
          );
  }
}
