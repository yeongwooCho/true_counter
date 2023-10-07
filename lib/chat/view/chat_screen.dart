import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:true_counter/chat/component/first_chat.dart';
import 'package:true_counter/chat/component/second_chat.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/common/util/show_cupertino_alert.dart';
import 'package:true_counter/festival/provider/festival_provider.dart';
import 'package:true_counter/festival/repository/festival_repository.dart';

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
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );

                    // await like(
                    //   context: context,
                    //   chatId: widget.chats[index].id,
                    // );
                  },
                  onTapDeclaration: () async {
                    festivalProvider.pushDeclaration(
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );

                    // await declaration(
                    //   context: context,
                    //   chatId: widget.chats[index].id,
                    // );
                  },
                );
              } else {
                return SecondChat(
                  chat: widget.chats[index],
                  onTapLike: () {
                    festivalProvider.pushLike(
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );

                    // await like(
                    //   context: context,
                    //   chatId: widget.chats[index].id,
                    // );
                  },
                  onTapDeclaration: () {
                    festivalProvider.pushDeclaration(
                      chatId: widget.chats[index].id,
                      festivalId: widget.festivalId,
                    );

                    // await declaration(
                    //   context: context,
                    //   chatId: widget.chats[index].id,
                    // );
                  },
                );
              }
            },
          );
  }

// Future<void> like({
//   required BuildContext context,
//   required int chatId,
// }) async {
//   final bool isSuccess = await festivalRepository.pushLike(chatId: chatId);
//
//   if (isSuccess) {
//     showCustomToast(
//       context,
//       msg: "좋아요를 표시합니다.",
//     );
//   } else {
//     showCustomToast(
//       context,
//       msg: "정상적이지 못한 요청입니다.",
//     );
//   }
// }
//
// Future<void> declaration({
//   required BuildContext context,
//   required int chatId,
// }) async {
//   showAlert(
//     context: context,
//     titleWidget: const Text('신고를 원하시면\n확인을 눌러주세요.'),
//     completeText: "신고하기",
//     completeFunction: () async {
//       final bool isSuccess =
//           await festivalRepository.pushDeclaration(chatId: chatId);
//
//       if (isSuccess) {
//         showCustomToast(
//           context,
//           msg: "신고가 완료 되었습니다.",
//         );
//       } else {
//         showCustomToast(
//           context,
//           msg: "정상적이지 못한 요청입니다.",
//         );
//       }
//
//       Navigator.of(context).pop();
//     },
//     cancelText: "취소",
//     cancelFunction: () {
//       Navigator.of(context).pop();
//     },
//   );
// }
}
