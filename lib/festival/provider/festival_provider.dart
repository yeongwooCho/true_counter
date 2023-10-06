import 'dart:math';

import 'package:flutter/material.dart';
import 'package:true_counter/chat/model/chat_model.dart';
import 'package:true_counter/festival/model/festival_model.dart';
import 'package:true_counter/festival/repository/festival_repository.dart';
import 'package:true_counter/user/model/user_model.dart';
import 'package:uuid/uuid.dart';

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
    required int? parentChatId,
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

// void createSchedule({
//   required ScheduleModel schedule,
// }) async {
//   final targetDate = schedule.date;
//
//   // 해당 uuid는 클라이언트에서 임시로 사용하는 uuid 이다.
//   final uuid = Uuid();
//   final targetId = uuid.v4();
//   final newSchedule = schedule.copyWith(id: targetId);
//
//   cache.update(
//     targetDate,
//     (value) => [...value, newSchedule]
//       ..sort((a, b) => a.startTime.compareTo(b.startTime)),
//     ifAbsent: () => [newSchedule],
//   );
//   notifyListeners();
//
//   try {
//     final savedSchedule = await repository.createSchedule(schedule: schedule);
//
//     cache.update(
//       targetDate,
//       (value) => value
//           .map((element) => element.id == targetId
//               ? element.copyWith(id: savedSchedule)
//               : element)
//           .toList(),
//     );
//   } catch (error) {
//     debugPrint(error.toString());
//
//     cache.update(
//       targetDate,
//       (value) => value.where((element) => element.id != targetId).toList(),
//     );
//   }
//   notifyListeners();
// }
}
