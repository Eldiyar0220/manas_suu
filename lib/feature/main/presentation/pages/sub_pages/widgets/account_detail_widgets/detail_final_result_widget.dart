import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/account_detail_widgets/detail_row_widget.dart';

class DetailFinalResultWidget extends StatelessWidget {
  const DetailFinalResultWidget(this.services, {super.key});

  final List<AccountDetailServiceItem>? services;

  static String _som(BuildContext context, double? v) =>
      '${(v ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}';

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
                context.tr(LocaleKeys.historyCharges),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textWhiteBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.settings_outlined,
                size: 18,
                color: AppColors.mainColor,
              ),
              const SizedBox(width: 6),
              CustomText(
                context.tr(LocaleKeys.historyServices),
                style: TextStyle(
                  fontSize: 14,
                  color: context.theme.textWhiteBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...(services ?? const <AccountDetailServiceItem>[]).map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    s.name ?? '—',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.theme.textWhiteBlackColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DetailRowWidget(
                    label: context.tr(LocaleKeys.historyVolume),
                    value:
                        '${(s.cubicMeters ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.unitPeople)}',
                  ),
                  const SizedBox(height: 4),
                  DetailRowWidget(
                    label: context.tr(LocaleKeys.historyCubicMeters),
                    value:
                        '${(s.cubicMeters ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.unitCubicMeters)}',
                  ),
                  const SizedBox(height: 4),
                  DetailRowWidget(
                    label: context.tr(LocaleKeys.historyTariff),
                    value: _som(context, s.tariff),
                  ),
                  const SizedBox(height: 4),
                  DetailRowWidget(
                    label: context.tr(LocaleKeys.historyAmount),
                    value: _som(context, s.amount),
                  ),
                  const SizedBox(height: 4),
                  DetailRowWidget(
                    label: context.tr(LocaleKeys.historyTax),
                    value: _som(context, s.tax),
                  ),
                  const SizedBox(height: 4),
                  DetailRowWidget(
                    label: context.tr(LocaleKeys.historyTotal),
                    value: _som(context, s.total),
                    valueBold: true,
                    valueColor: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
