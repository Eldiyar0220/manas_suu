import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

/// Суля дальше сам
abstract class AppThemes {
  static ThemeData mainThemeDark = ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.green, refreshBackgroundColor: Color(0xFF1C1C1E)),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    extensions: [
      MyColors(
        textWhiteBlackColor: AppColors.backgroundWhite,
        cardBackgroundWhiteBlackColor: Color(0xFF1C1C1E),
        historyBackgroundColor: const Color(0xFF000000),
        textSecondaryWhiteBlackColor: Colors.white70,
        iconSecondaryWhiteBlackColor: Colors.white70,
        historyIconContainerBackground: const Color(0xFF1F3A2F),
        userAccountBackground: [Color(0xFF0E1A14), Color(0xFF0A0A0A)],
        dayAndNight: Colors.black,
        nightAndDay: Colors.white,
        containerIconColor: Color(0xFF2d2d2d),
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
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.green,
      refreshBackgroundColor: AppColors.backgroundWhite,
    ),

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
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    extensions: [
      MyColors(
        textWhiteBlackColor: AppColors.backgroundBlack,
        cardBackgroundWhiteBlackColor: Colors.white,
        historyBackgroundColor: const Color(0xFFF4F4F4),
        textSecondaryWhiteBlackColor: Colors.black54,
        iconSecondaryWhiteBlackColor: Colors.black45,
        historyIconContainerBackground: const Color(0xFFE8F5E9),
        userAccountBackground: [
          const Color.fromARGB(255, 231, 233, 232),
          const Color.fromARGB(255, 236, 238, 237),
        ],
        dayAndNight: Colors.white,
        nightAndDay: Colors.black,
        containerIconColor: Color(0xfffafafa),
      ),
    ],
  );
}

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.textWhiteBlackColor,
    required this.cardBackgroundWhiteBlackColor,
    required this.historyBackgroundColor,
    required this.textSecondaryWhiteBlackColor,
    required this.iconSecondaryWhiteBlackColor,
    required this.historyIconContainerBackground,
    required this.userAccountBackground,
    required this.dayAndNight,
    required this.nightAndDay,
    required this.containerIconColor,
  });

  final Color? textWhiteBlackColor;
  final Color? cardBackgroundWhiteBlackColor;
  final Color? historyBackgroundColor;
  final Color? textSecondaryWhiteBlackColor;
  final Color? iconSecondaryWhiteBlackColor;
  final Color? historyIconContainerBackground;
  final List<Color>? userAccountBackground;
  final Color? dayAndNight;
  final Color? nightAndDay;
  final Color? containerIconColor;

  @override
  MyColors copyWith({
    Color? textWhiteBlackColor,
    Color? cardBackgroundWhiteBlackColor,
    Color? historyBackgroundColor,
    Color? textSecondaryWhiteBlackColor,
    Color? iconSecondaryWhiteBlackColor,
    Color? historyIconContainerBackground,
    List<Color>? userAccountBackground,
    Color? dayAndNight,
    Color? nightAndDay,
  }) {
    return MyColors(
      textWhiteBlackColor: textWhiteBlackColor ?? this.textWhiteBlackColor,
      cardBackgroundWhiteBlackColor:
          cardBackgroundWhiteBlackColor ?? this.cardBackgroundWhiteBlackColor,
      historyBackgroundColor:
          historyBackgroundColor ?? this.historyBackgroundColor,
      textSecondaryWhiteBlackColor:
          textSecondaryWhiteBlackColor ?? this.textSecondaryWhiteBlackColor,
      iconSecondaryWhiteBlackColor:
          iconSecondaryWhiteBlackColor ?? this.iconSecondaryWhiteBlackColor,
      historyIconContainerBackground:
          historyIconContainerBackground ?? this.historyIconContainerBackground,
      userAccountBackground: userAccountBackground ?? userAccountBackground,
      dayAndNight: dayAndNight ?? dayAndNight,
      nightAndDay: nightAndDay ?? nightAndDay,
      containerIconColor: containerIconColor ?? containerIconColor,
    );
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      textWhiteBlackColor: Color.lerp(
        textWhiteBlackColor,
        other.textWhiteBlackColor,
        t,
      ),
      cardBackgroundWhiteBlackColor: Color.lerp(
        cardBackgroundWhiteBlackColor,
        other.cardBackgroundWhiteBlackColor,
        t,
      ),
      historyBackgroundColor: Color.lerp(
        historyBackgroundColor,
        other.historyBackgroundColor,
        t,
      ),
      textSecondaryWhiteBlackColor: Color.lerp(
        textSecondaryWhiteBlackColor,
        other.textSecondaryWhiteBlackColor,
        t,
      ),
      iconSecondaryWhiteBlackColor: Color.lerp(
        iconSecondaryWhiteBlackColor,
        other.iconSecondaryWhiteBlackColor,
        t,
      ),
      historyIconContainerBackground: Color.lerp(
        historyIconContainerBackground,
        other.historyIconContainerBackground,
        t,
      ),
      userAccountBackground: userAccountBackground,
      dayAndNight: dayAndNight,
      nightAndDay: nightAndDay,
      containerIconColor: containerIconColor,
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(textWhiteBlackColor: $textWhiteBlackColor, cardBackgroundWhiteBlackColor: $cardBackgroundWhiteBlackColor)';
}

class AppThemeChangeButton extends StatelessWidget {
  const AppThemeChangeButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text(context.tr(LocaleKeys.themeLight)),
          onPressed: () {
            context.read<ThemeCubit>().changeTheme(ThemeMode.light);
          },
        ),
        ElevatedButton(
          child: Text(context.tr(LocaleKeys.themeDark)),
          onPressed: () {
            context.read<ThemeCubit>().changeTheme(ThemeMode.dark);
          },
        ),
      ],
    );
  }
}
