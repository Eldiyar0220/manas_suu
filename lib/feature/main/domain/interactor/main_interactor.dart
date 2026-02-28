import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/components/app_error_flushbar.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_chart_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/domain/repository/main_repository.dart';
import 'package:manas_suu_app/main.dart';

@injectable
class MainInteractor {
  MainInteractor(this._repository, this._preferenceHelper);
  final MainRepository _repository;
  final PreferenceHelper _preferenceHelper;

  List<AccountItemModel> myAccounts = [];
  AccountItemModel? selectedAccount;
  AccountDetailData? accountDetail;
  AccountChartData? accountChartData;
  int chartMonths = 3;

  Future<void> postAuthLogin(String personalAccount) async {
    if (personalAccount.isEmpty) {
      showErrorFlushbar('Заполните поле');
      return;
    }
    final result = await _repository.postAuthLogin(personalAccount);
    final prefs = _preferenceHelper.preferences;
    await prefs?.setString(
      PreferenceHelper.accessToken,
      result.data.refreshToken,
    );
    String fcmToken = '';
    try {
      fcmToken = await messaging.getToken() ?? '';
      _repository.savePushTokenRepo(await messaging.getToken() ?? '');
    } catch (_) {}
  }

  Future<void> getMyAccounts() async {
    myAccounts = await _repository.getMyAccounts();
    if (myAccounts.isEmpty) {
      selectedAccount = null;
      await _preferenceHelper.clear();
      return;
    }
    if (myAccounts.length == 1) {
      selectAccount(myAccounts.first.personalAccount);
    } else {
      selectAccount('');
    }
  }

  Future<void> selectAccount(String personalAccount) async {
    final prefs = _preferenceHelper.preferences;
    final cachedPersonalAcc = _preferenceHelper.preferences?.getString(
      PreferenceHelper.personalAccount,
    );
    if ((cachedPersonalAcc == null || cachedPersonalAcc.isEmpty) &&
        personalAccount.isEmpty &&
        myAccounts.isNotEmpty) {
      selectedAccount = myAccounts.first;
      await prefs?.setString(
        PreferenceHelper.personalAccount,
        selectedAccount!.personalAccount,
      );
      return;
    }
    if (cachedPersonalAcc != null &&
        cachedPersonalAcc.isNotEmpty &&
        personalAccount.isEmpty &&
        myAccounts.any((v) => v.personalAccount == cachedPersonalAcc)) {
      selectedAccount = myAccounts.firstWhere(
        (v) => v.personalAccount == cachedPersonalAcc,
      );
      return;
    }
    if (myAccounts.any((v) => v.personalAccount == personalAccount)) {
      selectedAccount = myAccounts.firstWhere(
        (v) => v.personalAccount == personalAccount,
      );
      await prefs?.setString(PreferenceHelper.personalAccount, personalAccount);
    } else if (myAccounts.isNotEmpty && personalAccount.isEmpty) {
      selectedAccount = myAccounts.first;
      await prefs?.setString(
        PreferenceHelper.personalAccount,
        selectedAccount!.personalAccount,
      );
    }
  }

  Future<void> addAccount(String personalAccount) async {
    if (personalAccount.isEmpty) {
      showErrorFlushbar('Заполните поле');
      return;
    }
    await _repository.addAccount(personalAccount);
  }

  Future<void> deleteAccount(int id) async =>
      await _repository.deleteAccount(id);

  Future<void> getAccountDetail(int accountId) async {
    accountDetail = await _repository.getAccountDetail(accountId);
  }

  Future<void> getAccountChart(int accountId, int months) async {
    accountChartData = await _repository.getAccountChart(accountId, months);
    chartMonths = months;
    log('data-unique: accountChartData: $accountChartData ');
  }
}
