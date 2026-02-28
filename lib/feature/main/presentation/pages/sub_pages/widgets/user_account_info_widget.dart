import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class UserAccountInfoWidget extends StatelessWidget {
  const UserAccountInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.watch<ThemeCubit>().state.isDarkMode
              ? AppColors.infoBorder
              : AppColors.infoBorderLight,
        ),
        color: context.watch<ThemeCubit>().state.isDarkMode
            ? AppColors.infoBackground
            : Colors.green.withValues(alpha: 0.08),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: context.watch<ThemeCubit>().state.isDarkMode
                ? Colors.green
                : AppColors.textPrimaryLight,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  context.tr(LocaleKeys.mainPageWhereToFind),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.watch<ThemeCubit>().state.isDarkMode
                        ? Colors.white
                        : const Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  context.tr(LocaleKeys.mainPageShowed),
                  style: TextStyle(
                    color: context.watch<ThemeCubit>().state.isDarkMode
                        ? Colors.white60
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
