import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/auth_login/auth_login_response_model.dart';
import 'package:manas_suu_app/feature/main/domain/repository/main_repository.dart';

@Injectable(as: MainRepository)
class MainRepositoryImpl implements MainRepository {
  MainRepositoryImpl(this._dio);
  final Dio _dio;

  final _authLogin = 'auth/login';
  final _accountsMy = 'accounts/my';

  @override
  Future<AuthLoginResponseModel> postAuthLogin(String personalAccount) async {
    final response = await _dio.post(_authLogin, data: {'personalAccount': personalAccount});

    return AuthLoginResponseModel.fromJson(response.data);
  }

  @override
  Future<List<AccountItemModel>> getMyAccounts() async {
    final response = await _dio.get(_accountsMy);

    return AccountsResponseModel.fromJson(response.data).data;
  }
}
