part of 'splash_bloc.dart';
sealed class SplashState extends Equatable {}

class SplashSuccessState extends SplashState {
  SplashSuccessState({required this.model});
  final SplashModel? model;

  @override
  List<Object?> get props => [model];
}

class SplashLoadingState extends SplashState {
  @override
  List<Object?> get props => [];  
}

class SplashErrorState extends SplashState {
  SplashErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
