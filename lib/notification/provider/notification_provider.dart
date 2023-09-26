import 'package:flutter/material.dart';
import 'package:true_counter/notification/model/notification_model.dart';
import 'package:true_counter/notification/repository/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository repository;
  Map<String, List<NotificationModel>> cache = {};

  NotificationProvider({
    required this.repository,
  }) : super() {
    getNotifications();
  }

  void getNotifications() async {
    final resp = await repository.getNotifications();

    cache.update('', (value) => resp, ifAbsent: () => resp);

    notifyListeners();
  }
}
