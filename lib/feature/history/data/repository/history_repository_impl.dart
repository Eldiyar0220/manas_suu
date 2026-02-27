import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';
import 'package:manas_suu_app/feature/history/domain/repository/history_repository.dart';
import 'package:path_provider/path_provider.dart';

@Singleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<HistoryData> getHistory(int? accId) async {
    final response = await _dio.get('accounts/$accId/history');
    return HistoryResponse.fromJson(response.data).data;
  }

  @override
  Future<String> getHistoryCheck({
    required int accountId,
    required int year,
    required int month,
  }) async {
    final dir = await getTemporaryDirectory();
    final fileName = 'receipt_${accountId}_${year}_$month.pdf';
    final savePath = '${dir.path}/$fileName';

    await _dio.download(
      'accounts/$accountId/receipt',
      savePath,
      queryParameters: {'year': year, 'month': month},
    );

    return savePath;
  }
}
