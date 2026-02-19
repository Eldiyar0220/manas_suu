part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {}

class ToSplashEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
