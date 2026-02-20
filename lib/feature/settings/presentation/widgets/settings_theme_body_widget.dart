import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_header_title_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_select_item_widget.dart';

class SettingsThemeBodyWidget extends StatelessWidget {
  const SettingsThemeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardBackgroundWhiteBlackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeaderTitleWidget(title: context.tr(LocaleKeys.themeApp), icon: Icons.palette),
          const SizedBox(height: 16),
          SettingsSelectItemWidget(
            value: ThemeMode.light.name,
            icon: Icons.light_mode,
            groupValue: context.watch<ThemeCubit>().state.themeMode.name,
            title: context.tr(LocaleKeys.themeLight),
            onTap: () => context.read<ThemeCubit>().changeTheme(ThemeMode.light),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            value: ThemeMode.dark.name,
            icon: Icons.dark_mode,

            groupValue: context.watch<ThemeCubit>().state.themeMode.name,
            title: context.tr(LocaleKeys.themeDark),
            onTap: () => context.read<ThemeCubit>().changeTheme(ThemeMode.dark),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            icon: Icons.brightness_auto,

            value: ThemeMode.system.name,
            groupValue: context.watch<ThemeCubit>().state.themeMode.name,
            title: context.tr(LocaleKeys.themeSystem),
            onTap: () => context.read<ThemeCubit>().changeTheme(ThemeMode.system),
          ),
        ],
      ),
    );
  }
}
