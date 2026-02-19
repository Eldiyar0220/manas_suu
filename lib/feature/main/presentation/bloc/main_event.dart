part of 'main_bloc.dart';
sealed class MainEvent extends Equatable {}

class ToMainEvent extends MainEvent {
  ToMainEvent({required this.model});
  final MainModel model;

  @override
  List<Object?> get props => [model];
}
