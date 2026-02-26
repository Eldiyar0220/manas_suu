import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:manas_suu_app/app/components/app_error_flushbar.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/core/dio_settings/app_exception.dart';

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
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = GetIt.I<PreferenceHelper>().preferences;
    final tokens = prefs?.getString(PreferenceHelper.accessToken);
    if (tokens != null) {
      options.headers = {'authorization': 'Bearer $tokens'};
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = AppException.fromDioException(err);
    showAppExceptionFlushbar(appException);
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: appException, type: err.type, response: err.response),
    );
  }
}
