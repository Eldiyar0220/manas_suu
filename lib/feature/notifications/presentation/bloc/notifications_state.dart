part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {}

class NotificationsSuccessState extends NotificationsState {
  NotificationsSuccessState({required this.items});
  final List<NotificationsModel> items;

  @override
  List<Object?> get props => [items];
}

class NotificationsLoadingState extends NotificationsState {
  @override
  List<Object?> get props => [];
}

class NotificationsErrorState extends NotificationsState {
  NotificationsErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
