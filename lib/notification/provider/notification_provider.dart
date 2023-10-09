import 'package:flutter/material.dart';
import 'package:true_counter/notification/model/notification_model.dart';
import 'package:true_counter/notification/repository/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository repository;
  Map<DateTime, List<NotificationModel>> cache = {};

  NotificationProvider({
    required this.repository,
  }) : super() {
    // getNotifications();
  }

  void getNotifications() async {
    final resp = await repository.getNotifications();

    if (resp.isEmpty) {
      return;
    }

    List<DateTime> dateTimes = resp.map((e) => e.createdAt).toList();
    dateTimes.sort((prev, next) => next.compareTo(prev));
    DateTime latestCreatedAt = dateTimes.first;

    if (!cache.keys.contains(latestCreatedAt)) {
      cache.clear();
      cache.update(latestCreatedAt, (value) => resp, ifAbsent: () => resp);
    }

    notifyListeners();
  }

  void createNotification({
    required String title,
    required String content,
  }) async {
    final resp = await repository.createNotification(
      title: title,
      content: content,
    );
    if (resp != null) {
      getNotifications();
    }
  }
}
