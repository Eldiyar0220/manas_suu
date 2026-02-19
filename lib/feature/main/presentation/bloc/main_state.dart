part of 'main_bloc.dart';
sealed class MainState extends Equatable {}

class MainSuccessState extends MainState {
  MainSuccessState({required this.model});
  final MainModel? model;

  @override
  List<Object?> get props => [model];
}

class MainLoadingState extends MainState {
  @override
  List<Object?> get props => [];  
}

class MainErrorState extends MainState {
  MainErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
