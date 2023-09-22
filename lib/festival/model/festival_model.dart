class FestivalModel {
  late String id;
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
  DateTime? userParticipationAt;
  // late bool isValid; // 관리자 허락한 데이터만 받으면 되기에 필요 X
  // late DateTime created_dt;
  // late DateTime update_dt;
  // late DateTime deleted_dt;

  // TODO: Dummy
  FestivalModel({
    required this.id,
    required this.title,
    required this.region,
    required this.applicant,
    required this.applicantPhone,
    required this.message,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.address,
    required this.startAt,
    required this.endAt,
    required this.cumulativeParticipantCount,
    this.userParticipationAt,
  });

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
    festival.startAt = json['startAt'] ?? '';
    festival.endAt = json['endAt'] ?? '';
    festival.cumulativeParticipantCount =
        json['cumulativeParticipantCount'] ?? '';
    festival.userParticipationAt = json['userParticipationAt'] ?? '';

    return festival;
  }
}
