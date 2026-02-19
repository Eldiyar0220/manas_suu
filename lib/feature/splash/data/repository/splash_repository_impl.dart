import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/splash/domain/repository/splash_repository.dart';

@Singleton(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl(this._dio);
  final Dio _dio;

  final String _getList = 'character?page=1';

  @override
  Future<String> exampleFuncRepo() async {
    final response = await _dio.get(_getList);
    log('data-unique: response: $response ');
    return 'SplashModel.fromJson(response.data).data';
  }
}
