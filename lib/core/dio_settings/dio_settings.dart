import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @dev
  @Named('BaseUrl')
  String get devBaseUrl => 'https://rickandmortyapi.com/api/';

  @prod
  @Named('BaseUrl')
  String get prodBaseUrl => 'https://rickandmortyapi.com/api/';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String baseUrl) {
    const duration = Duration(milliseconds: 55000);

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        connectTimeout: duration,
        receiveTimeout: duration,
        headers: {'Accept': 'application/json'},
      ),
    );

    final interceptors = dio.interceptors;
    interceptors.clear();

    final logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );

    final headerInterceptors = QueuedInterceptorsWrapper(
      onRequest: (options, handler) => handler.next(options),
      onError: (err, handler) => handler.next(err),
      onResponse: (response, handler) => handler.next(response),
    );

    interceptors.addAll([if (kDebugMode) logInterceptor, headerInterceptors]);

    return dio;
  }
}
