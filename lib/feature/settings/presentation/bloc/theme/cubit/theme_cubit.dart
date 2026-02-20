import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:manas_suu_app/app/constants/preference_helper.dart';

@singleton
class ThemeInteractor {
  final PreferenceHelper _preferenceHelper;

  ThemeInteractor(this._preferenceHelper);

  late ThemeMode mode; // для отображения темы в приложении
  bool isDarkMode = false;

  Future<void> init() async {
    final currentBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final savedMode = _preferenceHelper.preferences?.getString('themeMode');
    switch (savedMode) {
      case 'ThemeMode.dark':
        mode = ThemeMode.dark;
        isDarkMode = true;

        break;
      case 'ThemeMode.light':
        mode = ThemeMode.light;
        isDarkMode = false;

        break;
      default:
        mode = ThemeMode.system;
        if (currentBrightness == Brightness.dark) {
          isDarkMode = true;
        } else {
          isDarkMode = false;
        }
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    final currentBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    await _preferenceHelper.preferences?.setString('themeMode', theme.toString());

    mode = theme;
    switch (theme) {
      case ThemeMode.dark:
        isDarkMode = true;

        break;
      case ThemeMode.light:
        isDarkMode = false;

        break;

      case ThemeMode.system:
        if (currentBrightness == Brightness.dark) {
          isDarkMode = true;
        } else {
          isDarkMode = false;
        }
        break;
    }
  }
}

@singleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._interactor) : super(ThemeState(themeMode: ThemeMode.system, isDarkMode: false));
  final ThemeInteractor _interactor;

  void init() async {
    await _interactor.init();
    emit(ThemeState(themeMode: _interactor.mode, isDarkMode: _interactor.isDarkMode));
  }

  Future<void> changeTheme(ThemeMode mode) async {
    await _interactor.setTheme(mode);
    emit(ThemeState(themeMode: _interactor.mode, isDarkMode: _interactor.isDarkMode));
  }
}

class ThemeState {
  final ThemeMode themeMode;
  final bool isDarkMode;

  ThemeState({required this.themeMode, required this.isDarkMode});
}
