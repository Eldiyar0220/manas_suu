import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

/// Суля дальше сам
abstract class AppThemes {
  static ThemeData mainThemeDark = ThemeData(
    extensions: [
      MyColors(
        textWhiteBlackColor: AppColors.backgroundWhite,
        cardBackgroundWhiteBlackColor: AppColors.backgroundBlack,
      ),
    ],
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundBlack,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: AppColors.backgroundWhite),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.backgroundBlack,
      // titleTextStyle: AppTextDark.text20W500,
    ),
    textTheme: TextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundBlack,
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
    scaffoldBackgroundColor: AppColors.backgroundWhite,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: AppColors.backgroundBlack),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: AppColors.backgroundWhite,
      // titleTextStyle: AppTextsLight.text20W500,
    ),
    textTheme: TextTheme(),
    inputDecorationTheme: InputDecorationTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 5,
      backgroundColor: AppColors.backgroundWhite,
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
    extensions: [MyColors(textWhiteBlackColor: AppColors.backgroundBlack, cardBackgroundWhiteBlackColor: Colors.white)],
  );
}

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({required this.textWhiteBlackColor, required this.cardBackgroundWhiteBlackColor});

  final Color? textWhiteBlackColor;
  final Color? cardBackgroundWhiteBlackColor;

  @override
  MyColors copyWith({Color? textWhiteBlackColor, Color? cardBackgroundWhiteBlackColor}) {
    return MyColors(
      textWhiteBlackColor: textWhiteBlackColor ?? this.textWhiteBlackColor,
      cardBackgroundWhiteBlackColor: cardBackgroundWhiteBlackColor ?? this.cardBackgroundWhiteBlackColor,
    );
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      textWhiteBlackColor: Color.lerp(textWhiteBlackColor, other.textWhiteBlackColor, t),
      cardBackgroundWhiteBlackColor: Color.lerp(cardBackgroundWhiteBlackColor, other.cardBackgroundWhiteBlackColor, t),
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(textWhiteBlackColor: $textWhiteBlackColor, cardBackgroundWhiteBlackColor: $cardBackgroundWhiteBlackColor)';
}
