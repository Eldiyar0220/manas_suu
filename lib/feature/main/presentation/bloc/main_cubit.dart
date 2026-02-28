import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_chart_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/domain/interactor/main_interactor.dart';

enum MainStateStatus {
  AUTHSUCCESS,
  MYACCOUNTSUCCESS,
  ERROR,
  LOADING,
  INITIAL,
  ACCOUNTDETAILSUCCESS,
  CHARTSUCCESS,
}

@singleton
class MainCubit extends Cubit<MainState> {
  MainCubit(this._interactor)
    : super(MainState(status: MainStateStatus.LOADING));

  final MainInteractor _interactor;

  MainState _mainState(MainStateStatus status) {
    return MainState(
      status: status,
      myAccounts: _interactor.myAccounts,
      selectedAccount: _interactor.selectedAccount,
      accountDetail: _interactor.accountDetail,
      accountChartData: _interactor.accountChartData,
      chartMonths: _interactor.chartMonths,
    );
  }

  Future<void> postAuthLogin(String personalAccount) async {
    emit(_mainState(MainStateStatus.LOADING));
    EasyLoading.show();
    try {
      await _interactor.postAuthLogin(personalAccount);
      emit(_mainState(MainStateStatus.AUTHSUCCESS));
    } catch (e) {
      emit(_mainState(MainStateStatus.ERROR));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getMyAccounts({bool isAddedAccount = false}) async {
    final accessToken = GetIt.I<PreferenceHelper>().preferences?.getString(
      PreferenceHelper.accessToken,
    );
    if (accessToken != null) {
      emit(_mainState(MainStateStatus.LOADING));

      try {
        await _interactor.getMyAccounts();

        if (_interactor.myAccounts.isEmpty) {
          emit(MainState(status: MainStateStatus.INITIAL));
          return;
        }
        if (isAddedAccount) {
          emit(_mainState(MainStateStatus.AUTHSUCCESS));
        } else {
          emit(_mainState(MainStateStatus.MYACCOUNTSUCCESS));
        }
      } catch (e) {
        emit(_mainState(MainStateStatus.ERROR));
      }
    } else {
      emit(MainState(status: MainStateStatus.INITIAL));
    }
  }

  Future<void> selectAccount(String personalAccount) async {
    emit(_mainState(MainStateStatus.LOADING));
    try {
      await _interactor.selectAccount(personalAccount);
      emit(_mainState(MainStateStatus.MYACCOUNTSUCCESS));
    } catch (e) {
      emit(_mainState(MainStateStatus.ERROR));
    }
  }

  Future<void> addAccount(String personalAccount) async {
    emit(_mainState(MainStateStatus.LOADING));
    try {
      await _interactor.addAccount(personalAccount);
      getMyAccounts(isAddedAccount: true);
    } catch (e) {
      emit(_mainState(MainStateStatus.ERROR));
    }
  }

  Future<void> deleteAccount(int id) async {
    emit(_mainState(MainStateStatus.LOADING));
    try {
      await _interactor.deleteAccount(id);
      getMyAccounts();
    } catch (e) {
      emit(_mainState(MainStateStatus.ERROR));
    }
  }

  Future<void> getAccountDetail(int? accountId) async {
    if (accountId == null) return;
    EasyLoading.show();
    emit(_mainState(MainStateStatus.LOADING));
    try {
      await _interactor.getAccountDetail(accountId);
      emit(_mainState(MainStateStatus.ACCOUNTDETAILSUCCESS));
    } catch (e) {
      emit(_mainState(MainStateStatus.ERROR));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getAccountChart(int? accountId, {int months = 3}) async {
    if (accountId == null) return;
    emit(_mainState(MainStateStatus.LOADING));
    try {
      await _interactor.getAccountChart(accountId, months);
      emit(_mainState(MainStateStatus.CHARTSUCCESS));
    } catch (e) {
      emit(_mainState(MainStateStatus.ERROR));
    }
  }
}

class MainState extends Equatable {
  final MainStateStatus status;
  final List<AccountItemModel> myAccounts;
  final AccountItemModel? selectedAccount;
  final AccountDetailData? accountDetail;
  final AccountChartData? accountChartData;
  final int chartMonths;

  const MainState({
    this.status = MainStateStatus.INITIAL,
    this.myAccounts = const [],
    this.selectedAccount,
    this.accountDetail,
    this.accountChartData,
    this.chartMonths = 3,
  });

  @override
  List<Object?> get props => [status, accountChartData];
}
