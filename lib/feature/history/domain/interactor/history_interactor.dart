import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';
import 'package:manas_suu_app/feature/history/domain/repository/history_repository.dart';

@singleton
class HistoryInteractor {
  HistoryInteractor(this._repository);
  final HistoryRepository _repository;

  Future<HistoryData> getHistory(int? accId) async {
    try {
      return await _repository.getHistory(accId);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getHistoryCheck({
    required int accountId,
    required int year,
    required int month,
  }) async {
    try {
      return await _repository.getHistoryCheck(
        accountId: accountId,
        year: year,
        month: month,
      );
    } catch (e) {
      rethrow;
    }
  }
}
