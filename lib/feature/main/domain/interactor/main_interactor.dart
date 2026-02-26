import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/components/app_error_flushbar.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/domain/repository/main_repository.dart';

@injectable
class MainInteractor {
  MainInteractor(this._repository, this._preferenceHelper);
  final MainRepository _repository;
  final PreferenceHelper _preferenceHelper;

  List<AccountItemModel> myAccounts = [];
  AccountItemModel? selectedAccount;

  Future<void> postAuthLogin(String personalAccount) async {
    if (personalAccount.isEmpty) {
      showErrorFlushbar('Заполните поле');
      return;
    }
    final result = await _repository.postAuthLogin(personalAccount);
    final prefs = _preferenceHelper.preferences;
    await prefs?.setString(PreferenceHelper.accessToken, result.data.refreshToken);
  }

  Future<void> getMyAccounts() async {
    myAccounts = await _repository.getMyAccounts();
    if (myAccounts.length == 1) {
      selectAccount(myAccounts.first.personalAccount);
    } else {
      selectAccount('');
    }
  }

  Future<void> selectAccount(String personalAccount) async {
    final prefs = _preferenceHelper.preferences;
    final cachedPersonalAcc = _preferenceHelper.preferences?.getString(PreferenceHelper.personalAccount);
    if (cachedPersonalAcc != null && personalAccount.isEmpty) {
      selectedAccount = myAccounts.firstWhere((v) => v.personalAccount == cachedPersonalAcc);
    } else {
      selectedAccount = myAccounts.firstWhere((v) => v.personalAccount == personalAccount);

      await prefs?.setString(PreferenceHelper.personalAccount, personalAccount);
    }
  }
}
