part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {}

class LoadHistoryEvent extends HistoryEvent {
  LoadHistoryEvent({required this.personalAccount});

  final int personalAccount;

  @override
  List<Object?> get props => [personalAccount];
}

class GetHistoryCheckEvent extends HistoryEvent {
  GetHistoryCheckEvent({
    required this.accountId,
    required this.year,
    required this.month,
  });

  final int accountId;
  final int year;
  final int month;

  @override
  List<Object?> get props => [accountId, year, month];
}
