import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/feature/main/data/models/main_model.dart';
import 'package:manas_suu_app/feature/main/domain/interactor/main_interactor.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
MainBloc(this._interactor) : super(MainLoadingState()) {
  on<MainEvent>((event, emit) async {
    switch (event) {
      case ToMainEvent(:final model):
        {
          await onToMainEvent(model: model, emit: emit);
          break;
        }
    }
  });
}

  final MainInteractor _interactor;

  Future<void> onToMainEvent({
    required MainModel model,
    required Emitter<MainState> emit,
  }) async {
    emit(MainLoadingState());
    final result = await _interactor.exampleFunc();
  }
}
