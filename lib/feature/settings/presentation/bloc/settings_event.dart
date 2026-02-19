part of 'settings_bloc.dart';
sealed class SettingsEvent extends Equatable {}

class ToSettingsEvent extends SettingsEvent {
  ToSettingsEvent({required this.model});
  final SettingsModel model;

  @override
  List<Object?> get props => [model];
}
