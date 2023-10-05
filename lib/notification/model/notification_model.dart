class NotificationModel {
  late int id;
  late String title;
  late String content;
  late DateTime createdAt;

  // TODO: Dummy
  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  NotificationModel._internal();

  factory NotificationModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    NotificationModel notification = NotificationModel._internal();

    notification.id = json['id'];
    notification.title = json['title'] ?? '';
    notification.content = json['content'] ?? '';
    notification.createdAt = DateTime.parse(json['createdAt']);

    return notification;
  }

  @override
  String toString() {
    return 'NotificationModel = {id: $id, title: $title, content: $content, createdAt: $createdAt}';
  }
}
