import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/main/domain/repository/main_repository.dart';

@singleton
class MainInteractor {
  MainInteractor(this._repository);
  final MainRepository _repository;

  @override
  Future<void> exampleFunc() async {
    try {
      await _repository.exampleFuncRepo();
    } catch (e) {
      rethrow;
    }
  }
}
