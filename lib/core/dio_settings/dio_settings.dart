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
  String get prodBaseUrl => 'http://10.244.47.127:8080/tazalyk/';

  @dev
  @Named('APIKEY')
  String get devAPIKEY => 'rOhkc0AoXC6zl03MxsKeqa5OP6PeIF2E4YWX1Ndq';

  @prod
  @Named('APIKEY')
  String get prodAPIKEY => 'CV5riylMpjE933ebSPfS45LbDEhO61z5BbtHUK80';
  @dev
  @Named('ACCOUNTID')
  String get devACCOUNTID => 'a79d2a0a-3ce2-46dc-9332-8c4da9b8f209';

  @prod
  @Named('ACCOUNTID')
  String get prodACCOUNTID => '4f88cdfb-9546-4b58-a0e7-661328ec7efc';
  @dev
  @Named('CALLBACKURL')
  String get devCALLBACKURL => 'https://beta.api.paymentsgateway.averspay.kg/v1/graphql';

  @prod
  @Named('CALLBACKURL')
  String get prodCALLBACKURL => 'https://api.paymentsgateway.averspay.kg/v1/graphql';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String baseUrl) {
    const duration = Duration(milliseconds: 55000);

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        connectTimeout: duration,
        receiveTimeout: duration,
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
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
