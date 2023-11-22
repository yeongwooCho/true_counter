import 'package:flutter/material.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/const/colors.dart';
import 'package:true_counter/common/const/text_style.dart';
import 'package:true_counter/common/util/datetime.dart';

class FirstChat extends StatelessWidget {
  final ChatModel chat;

  final void Function({required int parentChatId}) changeParentId;
  final void Function() onTapLike;
  final void Function() onTapDeclaration;
  final void Function() onTapDelete;

  const FirstChat({
    Key? key,
    required this.chat,
    required this.changeParentId,
    required this.onTapLike,
    required this.onTapDeclaration,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chat.nickName,
                style: MyTextStyle.bodyTitleBold,
              ),
              Container(
                height: 32.0,
                decoration: BoxDecoration(
                  color: DARK_GREY_COLOR,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        changeParentId(parentChatId: chat.id);
                      },
                      child: Text(
                        '댓글',
                        style: MyTextStyle.descriptionRegular.copyWith(
                          color: WHITE_TEXT_COLOR,
                        ),
                      ),
                    ),
                    Container(
                      color: WHITE_TEXT_COLOR,
                      width: 1.0,
                      height: 16.0,
                    ),
                    IconButton(
                      onPressed: onTapLike,
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
                    DropdownButton(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      icon: null,
                      iconSize: 0.0,
                      menuMaxHeight: 200.0,
                      isExpanded: false,
                      underline: const SizedBox(height: 1.0),
                      style: MyTextStyle.descriptionMedium,
                      value: "",
                      items: ["", '삭제', '신고'].map((String item) {
                        if (item == "") {
                          return DropdownMenuItem<String>(
                            enabled: false,
                            alignment: Alignment.center,
                            value: item,
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: MIDDLE_GREY_COLOR,
                            ),
                          );
                        }
                        return DropdownMenuItem<String>(
                          alignment: Alignment.center,
                          value: item,
                          child: Text(
                            item,
                            style: MyTextStyle.descriptionRegular.copyWith(
                              color: DEFAULT_TEXT_COLOR,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value == "신고") {
                          onTapDeclaration();
                        } else if (value == "삭제") {
                          // TODO: 댓글 삭제하기
                          print(value);
                          onTapDelete();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            chat.content,
            style: MyTextStyle.bodyRegular.copyWith(
              color: DARK_GREY_COLOR,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Text(
                convertDateTimeToMinute(datetime: chat.createdAt),
                style: MyTextStyle.descriptionRegular,
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
                style: MyTextStyle.descriptionRegular.copyWith(
                  color: ERROR_COLOR,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
