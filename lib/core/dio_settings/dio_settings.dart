import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/components/app_error_flushbar.dart';
import 'package:manas_suu_app/core/dio_settings/app_exception.dart';
import 'package:manas_suu_app/core/dio_settings/app_exception_interceptor.dart';
import 'package:manas_suu_app/core/dio_settings/device_data/device_data_helper.dart';
import 'package:manas_suu_app/main.dart';

@module
abstract class RegisterModule {
  @test
  @Named('BaseUrl')
  String get testBaseUrl => 'https://31.3.216.40/tazalyk/';

  @dev
  @Named('BaseUrl')
  String get devBaseUrl => 'http://10.244.47.127:8080/tazalyk/';

  @prod
  @Named('BaseUrl')
  String get prodBaseUrl => 'http://10.244.47.127:8080/tazalyk/';

  @dev
  @Named('APIKEY')
  String get devAPIKEY => 'rOhkc0AoXC6zl03MxsKeqa5OP6PeIF2E4YWX1Ndq';
  @test
  @Named('APIKEY')
  String get testAPIKEY => 'rOhkc0AoXC6zl03MxsKeqa5OP6PeIF2E4YWX1Ndq';

  @prod
  @Named('APIKEY')
  String get prodAPIKEY => 'CV5riylMpjE933ebSPfS45LbDEhO61z5BbtHUK80';

  @test
  @Named('ACCOUNTID')
  String get testACCOUNTID => 'a79d2a0a-3ce2-46dc-9332-8c4da9b8f209';
  @dev
  @Named('ACCOUNTID')
  String get devACCOUNTID => 'a79d2a0a-3ce2-46dc-9332-8c4da9b8f209';

  @prod
  @Named('ACCOUNTID')
  String get prodACCOUNTID => '4f88cdfb-9546-4b58-a0e7-661328ec7efc';

  @dev
  @Named('CALLBACKURL')
  String get devCALLBACKURL => 'https://beta.api.paymentsgateway.averspay.kg/v1/graphql';
  @test
  @Named('CALLBACKURL')
  String get testCALLBACKURL => 'https://31.3.216.40/tazalyk/payments/callback';

  @prod
  @Named('CALLBACKURL')
  String get prodCALLBACKURL => 'https://api.paymentsgateway.averspay.kg/v1/graphql';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String baseUrl) {
    const duration = Duration(milliseconds: 55000);
    final uri = Uri.tryParse(baseUrl);
    final isIpHost = uri != null && RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(uri.host);

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        connectTimeout: duration,
        receiveTimeout: duration,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (kDebugMode || (uri?.scheme == 'https' && isIpHost)) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (_, _, _) => true;
          return client;
        },
      );
    }

    final interceptors = dio.interceptors;
    interceptors.clear();

    final logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );

    final headerInterceptors = InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers.addAll(
          (await DeviceDataHelper.deviceData).toCamelCaseJson(),
        );
        String fcmToken = '';
        try {
          fcmToken = await messaging.getToken() ?? '';
        } catch (_) {
          // APNS token may not be ready yet on iOS; use empty and retry on next request
        }
        options.headers.addAll({'fcmToken': fcmToken});
        handler.next(options);
      },
      onError: (err, handler) {
        handler.next(err);
        showAppExceptionFlushbar(AppException.fromDioException(err));
      },
      onResponse: (response, handler) => handler.next(response),
    );
    interceptors.addAll([
      if (kDebugMode) logInterceptor,
      headerInterceptors,
      AppExceptionInterceptor(),
    ]);

    return dio;
  }
}
