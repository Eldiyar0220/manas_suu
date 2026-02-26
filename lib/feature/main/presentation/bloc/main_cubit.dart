import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/main/domain/interactor/main_interactor.dart';

enum MainStateStatus { AUTHSUCCESS, MYACCOUNTSUCCESS, ERROR, LOADING, INITIAL }

@singleton
class MainCubit extends Cubit<MainState> {
  MainCubit(this._interactor) : super(MainState(status: MainStateStatus.LOADING));

  final MainInteractor _interactor;

  MainState _mainState(MainStateStatus status) {
    return MainState(status: status, myAccounts: _interactor.myAccounts, selectedAccount: _interactor.selectedAccount);
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

  Future<void> getMyAccounts() async {
    final accessToken = GetIt.I<PreferenceHelper>().preferences?.getString(PreferenceHelper.accessToken);
    if (accessToken != null) {
      emit(_mainState(MainStateStatus.LOADING));

      try {
        await _interactor.getMyAccounts();
        emit(_mainState(MainStateStatus.MYACCOUNTSUCCESS));
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
}

class MainState extends Equatable {
  final MainStateStatus status;
  final List<AccountItemModel> myAccounts;
  final AccountItemModel? selectedAccount;

  const MainState({this.status = MainStateStatus.INITIAL, this.myAccounts = const [], this.selectedAccount});
  @override
  List<Object?> get props => [status];
}
