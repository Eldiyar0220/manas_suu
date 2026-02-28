import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/notifications/data/models/notifications_model.dart';
import 'package:manas_suu_app/feature/notifications/domain/repository/notifications_repository.dart';

@singleton
class NotificationsInteractor {
  NotificationsInteractor(this._repository);
  final NotificationsRepository _repository;

  Future<List<NotificationsModel>> getNotificationsList() async {
    try {
      return await _repository.getNotificationsList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markNotificationRead(int id) async {
    try {
      await _repository.markNotificationRead(id);
      await getNotificationsList();
    } catch (e) {
      rethrow;
    }
  }
}
