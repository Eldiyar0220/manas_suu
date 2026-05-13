import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/settings/data/models/settings_model.dart';
import 'package:manas_suu_app/feature/settings/domain/repository/settings_repository.dart';

@Singleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._dio);
  final Dio _dio;
  
  final String _getList = ' API ';

  @override
  Future<String> exampleFuncRepo() async {
    final response = await _dio.get(_getList);
    return SettingsModel.fromJson(response.data).name ?? '';
  }
}
