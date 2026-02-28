part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {}

class LoadNotificationsEvent extends NotificationsEvent {
  LoadNotificationsEvent();

  @override
  List<Object?> get props => [];
}

class MarkNotificationReadEvent extends NotificationsEvent {
  MarkNotificationReadEvent({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
