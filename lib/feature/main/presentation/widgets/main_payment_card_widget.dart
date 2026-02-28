import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class MainPaymentCardWidget extends StatelessWidget {
  const MainPaymentCardWidget({super.key, required this.accountNumber});

  final String accountNumber;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final dividerColor = isDark ? Colors.white12 : Colors.grey.shade200;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black38
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.mainColor.withValues(alpha: 0.12),
                ),
                child: const Icon(
                  Icons.arrow_downward,
                  color: AppColors.mainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                'К оплате',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: textColor,
                ),
              ),
              const Spacer(),
              const CustomText(
                '-0.80 сом',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainColor,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.chevron_right, color: subTextColor, size: 18),
            ],
          ),

          Divider(height: 24, color: dividerColor),

          _InfoRow(
            icon: Icons.credit_card,
            label: 'ЛС:',
            value: accountNumber,
            badgeText: 'Быт',
            isDark: isDark,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.person_outline,
            label: 'ФИО:',
            value: 'Султанова Д',
            isDark: isDark,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Адрес:',
            value: 'ул. С.Ибраимова 11-1, дом 8-под...',
            isDark: isDark,
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          Divider(height: 20, color: dividerColor),
          Row(
            children: [
              Expanded(
                child: _PillInfo(
                  icon: Icons.people_outline,
                  text: 'Зарегистрировано 2',
                  isDark: isDark,
                ),
              ),
              Container(width: 1, height: 30, color: dividerColor),
              Expanded(
                child: _PillInfo(
                  icon: Icons.people,
                  text: 'Проживают 2',
                  isDark: isDark,
                ),
              ),
            ],
          ),

          Divider(height: 20, color: dividerColor),

          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.mainColor),
              const SizedBox(width: 6),
              CustomText(
                'Дата обновления',
                style: TextStyle(fontSize: 12, color: subTextColor),
              ),
              const Spacer(),
              CustomText(
                '20.02.2026 17:06:04',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.check_circle,
                size: 14,
                color: AppColors.mainColor,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Center(
            child: CustomText(
              'Нажмите для деталей',
              style: TextStyle(fontSize: 12, color: subTextColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
    this.badgeText,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;
  final Color textColor;
  final Color subTextColor;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: subTextColor),
        const SizedBox(width: 8),
        CustomText(label, style: TextStyle(color: subTextColor, fontSize: 13)),
        const SizedBox(width: 4),
        Expanded(
          child: CustomText(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (badgeText != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.mainColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.home_outlined,
                  size: 12,
                  color: AppColors.mainColor,
                ),
                const SizedBox(width: 3),
                CustomText(
                  badgeText!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _PillInfo extends StatelessWidget {
  const _PillInfo({
    required this.icon,
    required this.text,
    required this.isDark,
  });
  final IconData icon;
  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14, color: AppColors.mainColor),
        const SizedBox(width: 4),
        CustomText(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
