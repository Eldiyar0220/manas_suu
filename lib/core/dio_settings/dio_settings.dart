import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/core/dio_settings/app_exception_interceptor.dart';

@module
abstract class RegisterModule {
  @dev
  @Named('BaseUrl')
  String get devBaseUrl => 'http://10.244.47.127:8080/tazalyk/';

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

    interceptors.addAll([if (kDebugMode) logInterceptor, headerInterceptors, AppExceptionInterceptor()]);

    return dio;
  }
}
