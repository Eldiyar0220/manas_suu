import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/feature/settings/data/models/settings_model.dart';
import 'package:manas_suu_app/feature/settings/domain/interactor/settings_interactor.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
SettingsBloc(this._interactor) : super(SettingsLoadingState()) {
  on<SettingsEvent>((event, emit) async {
    switch (event) {
      case ToSettingsEvent(:final model):
        {
          await onToSettingsEvent(model: model, emit: emit);
          break;
        }
    }
  });
}

  final SettingsInteractor _interactor;

  Future<void> onToSettingsEvent({
    required SettingsModel model,
    required Emitter<SettingsState> emit,
  }) async {
    emit(SettingsLoadingState());
    final result = await _interactor.exampleFunc();
  }
}
