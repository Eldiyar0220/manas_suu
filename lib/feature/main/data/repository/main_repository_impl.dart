import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/main/data/models/auth_login/auth_login_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_chart_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/domain/repository/main_repository.dart';

@Injectable(as: MainRepository)
class MainRepositoryImpl implements MainRepository {
  MainRepositoryImpl(this._dio);
  final Dio _dio;

  final _authLogin = 'auth/login';
  final _accountsMy = 'accounts/my';
  final _accountsAdd = 'accounts/add';
  final _accountsDelete = 'accounts';

  @override
  Future<AuthLoginResponseModel> postAuthLogin(String personalAccount) async {
    final response = await _dio.post(
      _authLogin,
      data: {'personalAccount': personalAccount},
    );

    return AuthLoginResponseModel.fromJson(response.data);
  }

  @override
  Future<List<AccountItemModel>> getMyAccounts() async {
    final response = await _dio.get(_accountsMy);

    return AccountsResponseModel.fromJson(response.data).data;
  }

  @override
  Future<void> addAccount(String personalAccount) async {
    await _dio.post(_accountsAdd, data: {'personalAccount': personalAccount});
  }

  @override
  Future<void> deleteAccount(int id) async =>
      await _dio.delete('$_accountsDelete/$id');

  @override
  Future<void> savePushTokenRepo(String pushToken) async {
    await _dio.put('auth/fcm-token', data: {'fcmToken': pushToken});
  }

  @override
  Future<AccountDetailData> getAccountDetail(int accountId) async {
    final response = await _dio.get('accounts/$accountId/detail');
    return AccountDetailResponse.fromJson(response.data).data;
  }

  @override
  Future<AccountChartData> getAccountChart(int accountId, int months) async {
    final response = await _dio.get(
      'accounts/$accountId/chart',
      queryParameters: {'months': months},
    );
    return AccountChartResponse.fromJson(response.data).data;
  }
}
