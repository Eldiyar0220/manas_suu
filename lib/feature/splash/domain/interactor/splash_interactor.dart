import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/splash/domain/repository/splash_repository.dart';

@singleton
class SplashInteractor {
  SplashInteractor(this._repository);
  final SplashRepository _repository;

  @override
  Future<void> exampleFunc() async {
    try {
      await _repository.exampleFuncRepo();
    } catch (e) {
      rethrow;
    }
  }
}
