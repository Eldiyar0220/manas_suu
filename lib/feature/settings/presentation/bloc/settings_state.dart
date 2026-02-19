part of 'settings_bloc.dart';
sealed class SettingsState extends Equatable {}

class SettingsSuccessState extends SettingsState {
  SettingsSuccessState({required this.model});
  final SettingsModel? model;

  @override
  List<Object?> get props => [model];
}

class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];  
}

class SettingsErrorState extends SettingsState {
  SettingsErrorState({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
