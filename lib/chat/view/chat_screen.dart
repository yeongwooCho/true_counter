import 'package:flutter/material.dart';
import 'package:true_counter/chat/component/first_chat.dart';
import 'package:true_counter/chat/component/second_chat.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/show_cupertino_alert.dart';

class ChatScreen extends StatelessWidget {
  final List<ChatModel> chats;
  final void Function({required int parentChatId}) changeParentId;

  const ChatScreen({
    Key? key,
    required this.chats,
    required this.changeParentId,
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
                  changeParentId: changeParentId,
                  onTapLike: () {},
                  onTapDeclaration: () {
                    declaration(context: context);
                  },
                );
              } else {
                return SecondChat(
                  chat: chats[index],
                  onTapLike: () {},
                  onTapDeclaration: () {
                    declaration(context: context);
                  },
                );
              }
            },
          );
  }

  void declaration({required BuildContext context}) {
    showAlert(
      context: context,

      titleWidget: const Text('신고를 원하시면\n확인을 눌러주세요.'),
      completeText: "신고하기",
      completeFunction: () {
        showCustomToast(
          context,
          msg: "신고가 완료 되었습니다.",
        );
        Navigator.of(context).pop();
      },
      cancelText: "취소",
      cancelFunction: () {
        Navigator.of(context).pop();
      },
    );
  }
}
