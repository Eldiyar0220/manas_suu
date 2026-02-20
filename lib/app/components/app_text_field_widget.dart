
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.watch<ThemeCubit>().state.isDarkMode
            ? AppColors.cardBackground
            : AppColors.cardBackgroundLight,
        border: Border.all(
          color: context.watch<ThemeCubit>().state.isDarkMode
              ? AppColors.cardBorder
              : AppColors.cardBorderLight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.credit_card,
            color: context.watch<ThemeCubit>().state.isDarkMode
                ? Colors.green
                : AppColors.textPrimaryLight,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: context.watch<ThemeCubit>().state.isDarkMode
                    ? Colors.white
                    : Colors.black87,
              ),
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Номер лицевого счета',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color:
                      context.watch<ThemeCubit>().state.isDarkMode
                      ? Colors.white38
                      : Colors.black38,
                ),
              ),
            ),
          ),
          Icon(
            Icons.qr_code,
            color: context.watch<ThemeCubit>().state.isDarkMode
                ? Colors.green
                : AppColors.textPrimaryLight,
          ),
        ],
      ),
    );
  }
}