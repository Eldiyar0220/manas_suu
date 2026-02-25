import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({super.key, required this.controller, this.onQrTap});

  final TextEditingController controller;
  final VoidCallback? onQrTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.watch<ThemeCubit>().state.isDarkMode ? AppColors.cardBackground : AppColors.cardBackgroundLight,
        border: Border.all(
          color: context.watch<ThemeCubit>().state.isDarkMode ? AppColors.cardBorder : AppColors.cardBorderLight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.credit_card,
            color: context.watch<ThemeCubit>().state.isDarkMode ? Colors.green : AppColors.textPrimaryLight,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onTapUpOutside: (event) => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
              style: TextStyle(color: context.watch<ThemeCubit>().state.isDarkMode ? Colors.white : Colors.black87),
              controller: controller,
              decoration: InputDecoration(
                hintText: context.tr(LocaleKeys.accountNumberHint),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: context.watch<ThemeCubit>().state.isDarkMode ? Colors.white38 : Colors.black38,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onQrTap,
            child: Icon(
              Icons.qr_code,
              color: context.watch<ThemeCubit>().state.isDarkMode ? Colors.green : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
