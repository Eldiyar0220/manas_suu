import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/splash/data/models/splash_model.dart';
import 'package:manas_suu_app/feature/splash/domain/interactor/splash_interactor.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._interactor) : super(SplashLoadingState()) {
    on<SplashEvent>((event, emit) async {
      log('data-unique: event: $event ');
      switch (event) {
        case ToSplashEvent():
          {
            log('data-unique: 1 ');
            await onToSplashEvent(emit: emit);
            break;
          }
      }
    });
  }

  final SplashInteractor _interactor;

  Future<void> onToSplashEvent({required Emitter<SplashState> emit}) async {
    emit(SplashLoadingState());
    final result = await _interactor.exampleFunc();
  }
}
