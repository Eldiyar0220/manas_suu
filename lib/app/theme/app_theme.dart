import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

abstract class AppThemes {
  static ThemeData mainThemeDark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.mainColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.mainColor,
      // titleTextStyle: AppTextDark.text20W500,
    ),
    textTheme: TextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.mainColor,
      selectedItemColor: AppColors.mainColor,
      unselectedItemColor: AppColors.mainColor,
      // selectedLabelStyle: AppTextDark.textBNB,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.mainColor,
      primaryContainer: AppColors.mainColor,
      onPrimary: AppColors.mainColor,
      secondary: AppColors.mainColor,
      onSecondary: Colors.white,
      error: Colors.yellow,
      onError: Colors.yellow,
      surface: AppColors.mainColor,
      onSurface: Colors.white,
    ),
  );

  static ThemeData isLightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.mainColor,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: AppColors.mainColor,
      // titleTextStyle: AppTextsLight.text20W500,
    ),
    textTheme: TextTheme(),
    inputDecorationTheme: InputDecorationTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 5,
      backgroundColor: AppColors.mainColor,
      selectedItemColor: AppColors.mainColor,
      unselectedItemColor: AppColors.mainColor,
      // selectedLabelStyle: AppTextsLight.textBNB,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainColor,
      primaryContainer: AppColors.mainColor,
      onPrimary: AppColors.mainColor,
      secondary: AppColors.mainColor,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.yellow,
      surface: AppColors.mainColor,
      onSurface: Colors.grey,
    ),
  );
}
