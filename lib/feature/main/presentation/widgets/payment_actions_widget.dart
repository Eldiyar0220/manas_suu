import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

/// Виджет кнопок оплаты: «Оплатить», «Печать счета», «История».
class PaymentActionsWidget extends StatelessWidget {
  const PaymentActionsWidget({super.key, this.onPay, this.onPrintInvoice, this.onHistory, required this.isRedButton});

  final VoidCallback? onPay;
  final VoidCallback? onPrintInvoice;
  final VoidCallback? onHistory;
  final bool isRedButton;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final secondaryBg = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE8E8E8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Кнопка «Оплатить»
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPay,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isRedButton
                      ? [Color.fromARGB(255, 187, 102, 102), Color.fromARGB(255, 160, 67, 67)]
                      : [Color(0xFF66BB6A), Color(0xFF43A047)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isRedButton ? Colors.red.withValues(alpha: 0.4) : AppColors.mainColor.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 24),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      context.tr(LocaleKeys.payButton),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Ряд: «Печать счета» и «История»
        Row(
          children: [
            Expanded(
              child: _SecondaryActionButton(
                icon: Icons.receipt_long_outlined,
                label: context.tr(LocaleKeys.printInvoice),
                backgroundColor: secondaryBg,
                onTap: onPrintInvoice,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SecondaryActionButton(
                icon: Icons.history,
                label: context.tr(LocaleKeys.history),
                backgroundColor: secondaryBg,
                onTap: onHistory,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({required this.icon, required this.label, required this.backgroundColor, this.onTap});

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Icon(icon, color: AppColors.mainColor, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
