import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';

class ChargesCardWidget extends StatelessWidget {
  const ChargesCardWidget({
    super.key,
    required this.services,
    required this.periodAccrued,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.dividerColor,
    required this.iconContainerBg,
    required this.accentGreen,
  });

  final List<HistoryService> services;
  final double periodAccrued;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
  final Color dividerColor;
  final Color iconContainerBg;
  final Color accentGreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconContainerBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: accentGreen,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              CustomText(
                context.tr(LocaleKeys.historyCharges),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.settings, size: 16, color: accentGreen),
              const SizedBox(width: 6),
              CustomText(
                context.tr(LocaleKeys.historyServices),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
          if (services.isEmpty) ...[
            const SizedBox(height: 12),
            CustomText(
              context.tr(LocaleKeys.historyNoServicesData),
              style: TextStyle(fontSize: 14, color: subTextColor),
            ),
          ] else ...[
            for (int i = 0; i < services.length; i++) ...[
              if (i > 0) Divider(height: 20, color: dividerColor),
              _ServiceItem(
                service: services[i],
                textColor: textColor,
                subTextColor: subTextColor,
                accentGreen: accentGreen,
              ),
            ],
            Divider(height: 24, color: dividerColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  context.tr(LocaleKeys.historyTotal),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                CustomText(
                  '${periodAccrued.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: accentGreen,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({
    required this.service,
    required this.textColor,
    required this.subTextColor,
    required this.accentGreen,
  });

  final HistoryService service;
  final Color textColor;
  final Color subTextColor;
  final Color accentGreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            service.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          _RowLabelValue(
            label: context.tr(LocaleKeys.historyVolume),
            value: '${service.volume} ${context.tr(LocaleKeys.unitPeople)}',
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 4),
          _RowLabelValue(
            label: context.tr(LocaleKeys.historyCubicMeters),
            value:
                '${service.cubicMeters.toStringAsFixed(2)} ${context.tr(LocaleKeys.unitCubicMeters)}',
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 4),
          _RowLabelValue(
            label: context.tr(LocaleKeys.historyTariff),
            value:
                '${service.tariff.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 4),
          _RowLabelValue(
            label: context.tr(LocaleKeys.historyAmount),
            value:
                '${service.amount.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 4),
          _RowLabelValue(
            label: context.tr(LocaleKeys.historyTax),
            value:
                '${service.tax.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
            textColor: textColor,
            subTextColor: subTextColor,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                context.tr(LocaleKeys.historyTotal),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              CustomText(
                '${service.total.toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: accentGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowLabelValue extends StatelessWidget {
  const _RowLabelValue({
    required this.label,
    required this.value,
    required this.textColor,
    required this.subTextColor,
  });

  final String label;
  final String value;
  final Color textColor;
  final Color subTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label, style: TextStyle(fontSize: 13, color: subTextColor)),
        CustomText(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
