import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/feature/notifications/data/models/notifications_model.dart';
import 'package:manas_suu_app/feature/notifications/domain/interactor/notifications_interactor.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(this._interactor) : super(NotificationsLoadingState()) {
    on<NotificationsEvent>(_onEvent);
  }

  final NotificationsInteractor _interactor;

  Future<void> _onEvent(
    NotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    switch (event) {
      case LoadNotificationsEvent():
        await _onLoadNotifications(event, emit);
        break;
      case MarkNotificationReadEvent():
        await _markNotificationRead(event, emit);
        break;
    }
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(NotificationsLoadingState());
    try {
      final items = await _interactor.getNotificationsList();
      emit(NotificationsSuccessState(items: items));
    } catch (e) {
      emit(NotificationsErrorState(message: e.toString()));
    }
  }

  Future<void> _markNotificationRead(
    MarkNotificationReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      await _interactor.markNotificationRead(event.id);
    } catch (e) {
      emit(NotificationsErrorState(message: e.toString()));
    }
  }
}
