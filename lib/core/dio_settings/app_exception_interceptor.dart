import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:manas_suu_app/app/components/app_error_flushbar.dart';
import 'package:manas_suu_app/app/constants/navigator_key.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/core/dio_settings/app_exception.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';

class AppExceptionInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (data is Map && data.containsKey('SUCCESS') && data['SUCCESS'] == false) {
      handler.reject(
        DioException(requestOptions: response.requestOptions, response: response, type: DioExceptionType.badResponse),
      );
      return;
    }
    handler.next(response);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final helper = GetIt.I<PreferenceHelper>();
    final prefs = helper.preferences;
    final token = prefs?.getString(PreferenceHelper.accessToken);
    if (token != null && token.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $token';
    }
    final context = navigatorKey.currentContext;
    final locale = context != null
        ? (EasyLocalization.of(context)?.locale ?? WidgetsBinding.instance.platformDispatcher.locale)
        : WidgetsBinding.instance.platformDispatcher.locale;
    options.headers['Accept-Language'] = locale.toLanguageTag();
    final deviceId = await helper.getOrCreateDeviceId();
    if (deviceId != null && deviceId.isNotEmpty) {
      options.headers['deviceId'] = deviceId;
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      GetIt.I<PreferenceHelper>().clear();
      GetIt.I<MainCubit>().getMyAccounts();
      handler.reject(
        DioException(requestOptions: err.requestOptions, error: err, type: err.type, response: err.response),
      );
    }
    final appException = AppException.fromDioException(err);
    showAppExceptionFlushbar(appException);
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: appException, type: err.type, response: err.response),
    );
  }
}
