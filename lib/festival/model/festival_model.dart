import 'package:true_counter/chat/model/chat_model.dart';

class FestivalModel {
  late int id;
  late String title;
  late String region; // 행사 지역

  late String applicant; // 주최자 이름 혹은 단체
  late String applicantPhone; // 주최자 전화번호
  late String message; // 주최자 전달사항

  late double latitude;
  late double longitude;
  late double radius; // 참여 가능 반경

  late String address; // 행사 주소
  late DateTime startAt; // 행사 시작 시간
  late DateTime endAt; // 행사 끝 시간

  late int cumulativeParticipantCount; // 누적 참여자 수
  late String participantsByTimezone;
  late bool isValid; // 관리자 승인 여부 - true
  late bool isParticipated; // 해당 유저의 참여여부
  late List<ChatModel> chats;

  // DateTime? userParticipationAt;

  FestivalModel._internal();

  factory FestivalModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    FestivalModel festival = FestivalModel._internal();

    festival.id = json['id'] ?? '';
    festival.title = json['title'] ?? '';
    festival.region = json['region'] ?? '';

    festival.applicant = json['applicant'] ?? '';
    festival.applicantPhone = json['applicantPhone'] ?? '';
    festival.message = json['message'] ?? '';

    festival.latitude = json['latitude'] ?? '';
    festival.longitude = json['longitude'] ?? '';
    festival.radius = json['radius'] ?? '';

    festival.address = json['address'] ?? '';
    festival.startAt = DateTime.parse(json['startAt']);
    festival.endAt = DateTime.parse(json['endAt']);
    // festival.userParticipationAt = DateTime.parse(json['userParticipationAt']);

    festival.cumulativeParticipantCount =
        json['cumulativeParticipantCount'] ?? 0;
    festival.participantsByTimezone = json['participantsByTimezone'] ?? '';
    festival.isValid = json['isValid'] ?? true;
    festival.isParticipated = json['isParticipated'] ?? false;

    if (json['chats'] != null) {
      festival.chats = json['chats'].map<ChatModel>((element) {
        return ChatModel.fromJson(json: element);
      }).toList();
    } else {
      festival.chats = [];
    }

    return festival;
  }
}
