import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';
import 'package:manas_suu_app/feature/history/domain/interactor/history_interactor.dart';

part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._interactor) : super(HistoryLoadingState()) {
    on<HistoryEvent>(_onEvent);
  }

  final HistoryInteractor _interactor;

  Future<void> _onEvent(HistoryEvent event, Emitter<HistoryState> emit) async {
    switch (event) {
      case LoadHistoryEvent():
        await _onLoadHistory(event, emit);
        break;
      case GetHistoryCheckEvent():
        await _getHistoryCheck(event, emit);
        break;
    }
  }

  Future<void> _onLoadHistory(
    LoadHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoadingState());
    EasyLoading.show();
    try {
      final model = await _interactor.getHistory(event.personalAccount);
      emit(HistorySuccessState(model: model));
      EasyLoading.dismiss();
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
      EasyLoading.dismiss();
    }
  }

  Future<void> _getHistoryCheck(
    GetHistoryCheckEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoadingState());
    EasyLoading.show();
    try {
      final filePath = await _interactor.getHistoryCheck(
        accountId: event.accountId,
        year: event.year,
        month: event.month,
      );
      emit(HistoryCheckSuccessState(filePath));
      EasyLoading.dismiss();
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
      EasyLoading.dismiss();
    }
  }
}
