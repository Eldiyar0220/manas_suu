import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_row_widget.dart';

class DetailOverPayWidget extends StatelessWidget {
  const DetailOverPayWidget(
    this.balance,
    this.openingBalance,
    this.accrued,
    this.tax,
    this.paid, {
    super.key,
  });

  final double balance;
  final double openingBalance;
  final double accrued;
  final double tax;
  final double paid;

  static String _som(BuildContext context, double v) =>
      '${v.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardBackgroundWhiteBlackColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mainColor),
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
                  color: AppColors.mainColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_downward,
                  color: AppColors.mainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                context.tr(LocaleKeys.overpayment),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textWhiteBlackColor,
                ),
              ),
              const Spacer(),
              Text(
                _som(context, balance),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DetailRowWidget(
            label: context.tr(LocaleKeys.detailAtPeriodStart),
            value: _som(context, openingBalance),
          ),
          const SizedBox(height: 8),
          DetailRowWidget(
            label: context.tr(LocaleKeys.historyAccrued),
            value: _som(context, accrued),
          ),
          const SizedBox(height: 8),
          DetailRowWidget(
            label: context.tr(LocaleKeys.taxes),
            value: _som(context, tax),
          ),
          const SizedBox(height: 8),
          DetailRowWidget(
            label: context.tr(LocaleKeys.historyPaid),
            value: _som(context, paid),
            valueBold: true,
            valueColor: AppColors.mainColor,
          ),
        ],
      ),
    );
  }
}
