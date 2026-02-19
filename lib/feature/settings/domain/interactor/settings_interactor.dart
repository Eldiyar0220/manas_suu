import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/settings/domain/repository/settings_repository.dart';

@singleton
class SettingsInteractor {
  SettingsInteractor(this._repository);
  final SettingsRepository _repository;

  @override
  Future<void> exampleFunc() async {
    try {
      await _repository.exampleFuncRepo();
    } catch (e) {
      rethrow;
    }
  }
}
