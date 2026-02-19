import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/news/data/models/news_model.dart';
import 'package:manas_suu_app/feature/news/domain/repository/news_repository.dart';

@Singleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._dio);
  final Dio _dio;
  
  final String _getList = ' API ';

  @override
  Future<String> exampleFuncRepo() async {
    final response = await _dio.get(_getList);
    return NewsModel.fromJson(response.data).name;
  }
}
