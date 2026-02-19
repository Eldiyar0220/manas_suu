import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/main/data/models/main_model.dart';
import 'package:manas_suu_app/feature/main/domain/repository/main_repository.dart';

@Singleton(as: MainRepository)
class MainRepositoryImpl implements MainRepository {
  MainRepositoryImpl(this._dio);
  final Dio _dio;
  
  final String _getList = ' API ';

  @override
  Future<String> exampleFuncRepo() async {
    final response = await _dio.get(_getList);
    return MainModel.fromJson(response.data).name;
  }
}
