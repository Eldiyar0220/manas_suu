import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class UserAccountHeaderWidget extends StatelessWidget {
  const UserAccountHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.iconCircleStart, AppColors.iconCircleEnd],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(Icons.credit_card, color: Colors.white, size: 40),
        ),

        const SizedBox(height: 24),

        Text(
          'Добро пожаловать!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: context.watch<ThemeCubit>().state.isDarkMode
                ? AppColors.textPrimary
                : AppColors.textPrimaryLight,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Укажите номер лицевого счета для доступа к счетам и управления услугами',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.watch<ThemeCubit>().state.isDarkMode
                ? AppColors.textSecondary
                : AppColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
