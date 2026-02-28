import 'package:manas_suu_app/feature/main/data/models/auth_login/auth_login_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';

abstract class MainRepository {
  Future<AuthLoginResponseModel> postAuthLogin(String personalAccount);
  Future<List<AccountItemModel>> getMyAccounts();
  Future<void> deleteAccount(int id);
  Future<void> addAccount(String personalAccount);
  Future<void> savePushTokenRepo(String pushToken);
  Future<AccountDetailData> getAccountDetail(int accountId);
}
