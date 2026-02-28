import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/notifications/data/models/notifications_model.dart';
import 'package:manas_suu_app/feature/notifications/domain/repository/notifications_repository.dart';

@Singleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<NotificationsModel>> getNotificationsList() async {
    final response = await _dio.get('notifications');
    return NotificationsResponse.fromJson(response.data).data;
  }

  @override
  Future<void> markNotificationRead(int id) async {
    await _dio.patch('notifications/$id/read');
  }
}
