import 'package:dio/dio.dart';
import 'package:true_counter/common/variable/data.dart';
import 'package:true_counter/notification/model/notification_model.dart';

class NotificationRepository {
  final _dio = Dio();

  Future<void> getNotification() async {
    // final resp = _dio.get('path');

    notifications = [
      NotificationModel(
        id: '1',
        title: '[공지] 2023년 5월 집회 / 행사 일정 안내123412341234',
        description:
            '동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세.무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.',
        createdAt: '2023-08-19',
      ),
      NotificationModel(
        id: '2',
        title: '2023년 8월 30일 현재 행사 성격별 ...',
        description:
            '동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세.무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.',
        createdAt: '2023-08-17',
      ),
      NotificationModel(
        id: '3',
        title: '2023년 7월 21일 광복절 행사 세부 안...',
        description:
            '동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세.무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.',
        createdAt: '2023-08-13',
      ),
      NotificationModel(
        id: '4',
        title: '[공지] 2023년 4월 집회 / 행사 일정 안내',
        description:
            '동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세.무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세.',
        createdAt: '2023-07-19',
      ),
    ];
  }
}
