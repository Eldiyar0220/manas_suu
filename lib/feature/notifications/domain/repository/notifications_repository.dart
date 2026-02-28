import 'package:manas_suu_app/feature/notifications/data/models/notifications_model.dart';

abstract class NotificationsRepository {
  Future<List<NotificationsModel>> getNotificationsList();
  Future<void> markNotificationRead(int id);
}
