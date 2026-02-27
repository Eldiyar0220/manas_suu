import 'package:manas_suu_app/feature/history/data/models/history_response.dart';

abstract class HistoryRepository {
  Future<HistoryData> getHistory(int? accId);
  Future<String> getHistoryCheck({
    required int accountId,
    required int year,
    required int month,
  });
}
