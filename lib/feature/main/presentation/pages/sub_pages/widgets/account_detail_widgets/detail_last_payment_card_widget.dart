import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class DetailLastPaymentCardWidget extends StatelessWidget {
  const DetailLastPaymentCardWidget(this.date, this.amount, {super.key});

  final String? date;
  final double? amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.textWhiteBlackColor,
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
                  color: context.theme.historyIconContainerBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.mainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                context.tr(LocaleKeys.lastPayment),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.theme.cardBackgroundWhiteBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: context.theme.cardBackgroundWhiteBlackColor,
              ),
              const SizedBox(width: 8),
              CustomText(
                date ?? '—',
                style: TextStyle(
                  fontSize: 14,
                  color: context.theme.cardBackgroundWhiteBlackColor,
                ),
              ),
              const Spacer(),
              if (amount != null)
                CustomText(
                  '${amount!.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
