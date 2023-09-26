class NotificationModel {
  late String id;
  late String title;
  late String description;
  late DateTime createdAt;

  // TODO: Dummy
  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  NotificationModel._internal();

  factory NotificationModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    NotificationModel notification = NotificationModel._internal();

    notification.id = json['id'] ?? '';
    notification.title = json['title'] ?? '';
    notification.description = json['description'] ?? '';
    notification.createdAt = json['createdAt'] ?? '';

    return notification;
  }
}
