import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/news/domain/repository/news_repository.dart';

@singleton
class NewsInteractor {
  NewsInteractor(this._repository);
  final NewsRepository _repository;

  @override
  Future<void> exampleFunc() async {
    try {
      await _repository.exampleFuncRepo();
    } catch (e) {
      rethrow;
    }
  }
}
