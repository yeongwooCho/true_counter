import 'dart:math';

import 'package:flutter/material.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/common/util/custom_toast.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/festival/repository/festival_repository.dart';
import 'package:true_counter/user/model/user_model.dart';

class FestivalProvider extends ChangeNotifier {
  final FestivalRepository repository;
  Map<String, List<FestivalModel>> cacheList = {};
  Map<int, FestivalModel> cache = {};

  FestivalProvider({
    required this.repository,
  }) : super() {
    // getFestivals();
  }

  void getFestivals() async {
    final resp = await repository.getFestivals();

    cacheList.update('total', (value) => resp, ifAbsent: () => resp);

    notifyListeners();
  }

  void getFestival({
    required int id,
  }) async {
    final resp = await repository.getFestival(id: id);

    if (resp != null) {
      cache.update(id, (value) => resp, ifAbsent: () => resp);
    }

    notifyListeners();
  }

  void createChat({
    required int festivalId,
    int? parentChatId,
    required String nickname,
    required String content,
  }) async {
    // chat 은 아이디가 int 이다.
    // final uuid = Uuid();
    // final targetId = uuid.v4();
    int randomId = Random().nextInt(100) - 100; // 0 ~ 99 랜덤
    DateTime now = DateTime.now();

    ChatModel newChat = ChatModel(
      id: randomId,
      parentChatId: parentChatId,
      nickName: UserModel.current!.nickname,
      content: content,
      createdAt: now,
    );

    FestivalModel? tempFestival;
    cache.update(festivalId, (value) {
      tempFestival = value;
      return value.copyWith(
        oldFestivalModel: value,
        newChatModel: newChat,
      );
    });

    notifyListeners();

    try {
      tempFestival!.chats =
          tempFestival!.chats.where((e) => e.id >= 0).toList();

      final ChatModel? chat = await repository.createChat(
        festivalId: festivalId,
        parentChatId: parentChatId,
        content: content,
      );
      print('새로운 책 $chat');

      cache.update(
        festivalId,
        (value) => value.copyWith(
          oldFestivalModel: tempFestival!,
          newChatModel: chat!,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
      print('에러인가?');

      cache.update(
        festivalId,
        (value) => tempFestival!,
      );
    }
    notifyListeners();
  }

  void participateFestival({
    required int festivalId,
  }) async {
    cacheList.update(
        'total',
        (value) => value.map((element) {
              if (element.id == festivalId) {
                element.isParticipated = true;
                return element;
              } else {
                return element;
              }
            }).toList());

    if (cache.containsKey(festivalId)) {
      cache.update(festivalId, (value) {
        value.isParticipated = true;
        return value;
      });
    }
    notifyListeners();
    print('캐시확인1');
    print(cacheList);
    print(cache);

    try {
      final resp = await repository.participateFestival(festivalId: festivalId);
      print('resp: $resp');

      if (!resp) {
        cacheList.update(
            'total',
            (value) => value.map((element) {
                  if (element.id == festivalId) {
                    element.isParticipated = false;
                    return element;
                  } else {
                    return element;
                  }
                }).toList());
        if (cache.containsKey(festivalId)) {
          cache.update(festivalId, (value) {
            value.isParticipated = false;
            return value;
          });
        }
      }
    } catch (e) {
      debugPrint('FestivalProvider participateFestival Error: ${e.toString()}');
    }
    print('캐시확인2');
    print(cacheList);
    print(cache);
    notifyListeners();
  }

  void pushLike({
    required BuildContext context,
    required int festivalId,
    required int chatId,
  }) async {
    final resp = await repository.pushLike(chatId: chatId);

    // FestivalModel? tempFestival;
    // cache.update(festivalId, (value) {
    //   tempFestival = value;
    //   return value.copyWith(
    //     oldFestivalModel: value,
    //     newChatModel: newChat,
    //   );
    // });

    if (resp != null) {
      final FestivalModel tempFestivalModel = cache[festivalId]!;
      final ChatModel tempChat = tempFestivalModel.chats.where((element) => element.id == chatId).first;
      tempChat.chatLike = resp;
      showCustomToast(context, msg: "좋아요를 눌렀습니다.");

      // cache.update(
      //   festivalId,
      //       (value) => value.copyWith(
      //     oldFestivalModel: tempFestivalModel,
      //     newChatModel: tempChat,
      //   ),
      // );
      // cache.update(festivalId, (value) {
      //   value.chats.map((e) => null)
      //   return ;
      // });
    } else {
      showCustomToast(context, msg: "이미 좋아요를 누른 댓글입니다.");
    }
    notifyListeners();
  }

  void pushDeclaration({
    required BuildContext context,
    required festivalId,
    required int chatId,
  }) async {
    final resp = await repository.pushDeclaration(chatId: chatId);

    if (!resp) {
      showCustomToast(context, msg: "이미 신고한 댓글입니다.");
    } else {
      showCustomToast(context, msg: "신고가 완료 되었습니다.");
    }

    notifyListeners();
  }
}
