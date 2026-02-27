import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

Future<void> showAccountActionsBottomSheet(
  BuildContext context, {
  required AccountItemModel account,
  VoidCallback? onDetails,
  VoidCallback? onHistory,
  VoidCallback? onDelete,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    builder: (context) =>
        _AccountActionsSheet(account: account, onDetails: onDetails, onHistory: onHistory, onDelete: onDelete),
  );
}

class _AccountActionsSheet extends StatelessWidget {
  const _AccountActionsSheet({required this.account, this.onDetails, this.onHistory, this.onDelete});

  final AccountItemModel account;
  final VoidCallback? onDetails;
  final VoidCallback? onHistory;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final cardColor = isDark ? const Color(0xFF222222) : Colors.white;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    final deleteBorder = isDark ? const Color(0xFF5A2A2A) : const Color(0xFFECCCCC);
    final deleteIconBg = isDark ? const Color(0xFF3B1F1F) : const Color(0xFFFFEEEE);
    void handleTap(VoidCallback? callback) {
      Navigator.of(context).maybePop();
      callback?.call();
    }

    return SafeArea(
      top: false,
      bottom: !Platform.isIOS,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF4F4F4),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            _AccountHeader(account: account, cardColor: cardColor, textColor: textColor, subTextColor: subTextColor),
            const SizedBox(height: 16),
            _ActionTile(
              icon: Icons.info_outline,
              label: context.tr(LocaleKeys.accountDetails),
              iconBg: isDark ? const Color(0xFF273121) : const Color(0xFFE9F5EE),
              iconColor: AppColors.mainColor,
              textColor: textColor,
              borderColor: AppColors.mainColor.withValues(alpha: 0.35),
              onTap: () => handleTap(onDetails),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.history,
              label: context.tr(LocaleKeys.accrualHistory),
              iconBg: isDark ? const Color(0xFF1F2A2F) : const Color(0xFFEAF1F5),
              iconColor: AppColors.mainColor,
              textColor: textColor,
              borderColor: AppColors.mainColor.withValues(alpha: 0.35),
              onTap: () => handleTap(onHistory),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              icon: Icons.delete_outline,
              label: context.tr(LocaleKeys.deleteAccount),
              iconBg: deleteIconBg,
              iconColor: Colors.red,
              textColor: textColor,
              borderColor: deleteBorder,
              onTap: () => handleTap(onDelete),
              trailingColor: Colors.red,
            ),
            const SizedBox(height: 4),
            Divider(color: dividerColor, height: 16),
          ],
        ),
      ),
    );
  }
}

class _AccountHeader extends StatelessWidget {
  const _AccountHeader({
    required this.account,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
  });

  final AccountItemModel account;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.mainColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.credit_card, color: AppColors.mainColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.personalAccount,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
              ),
              const SizedBox(height: 2),
              Text(account.fullName, style: TextStyle(fontSize: 13, color: subTextColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.iconBg,
    required this.iconColor,
    required this.textColor,
    required this.borderColor,
    this.onTap,
    this.trailingColor,
  });

  final IconData icon;
  final String label;
  final Color iconBg;
  final Color iconColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final Color? trailingColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
                ),
              ),
              Icon(Icons.chevron_right, color: trailingColor ?? AppColors.mainColor),
            ],
          ),
        ),
      ),
    );
  }
}
