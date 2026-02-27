part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {}

class HistoryLoadingState extends HistoryState {
  @override
  List<Object?> get props => [];
}

class HistorySuccessState extends HistoryState {
  HistorySuccessState({required this.model});

  final HistoryData model;

  @override
  List<Object?> get props => [model];
}

class HistoryErrorState extends HistoryState {
  HistoryErrorState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class HistoryCheckSuccessState extends HistoryState {
  HistoryCheckSuccessState(this.filePath);

  final String filePath;

  @override
  List<Object?> get props => [filePath];
}
