import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart';
import 'package:manas_suu_app/feature/main/data/models/myaccount/accounts_response_model.dart';

class DetailHeaderCardWidget extends StatelessWidget {
  const DetailHeaderCardWidget(this.detail, {super.key});
  final AccountDetailData detail;

  @override
  Widget build(BuildContext context) {
    const cardTextColor = Colors.white;
    const greenCard = LinearGradient(
      colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: greenCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                context.tr(LocaleKeys.detailPersonalAccount),
                style: TextStyle(
                  fontSize: 12,
                  color: cardTextColor.withValues(alpha: 0.9),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(
                  detail.periodLabel ?? '—',
                  style: const TextStyle(fontSize: 12, color: cardTextColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.credit_card,
                  size: 20,
                  color: cardTextColor,
                ),
              ),
              const SizedBox(width: 10),
              CustomText(
                detail.personalAccount ?? '—',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: cardTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.person_outline, size: 18, color: cardTextColor),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  detail.fullName ?? '—',
                  style: const TextStyle(fontSize: 14, color: cardTextColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: cardTextColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  detail.address ?? '—',
                  style: const TextStyle(fontSize: 14, color: cardTextColor),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.home_rounded,
                      size: 14,
                      color: cardTextColor,
                    ),
                    const SizedBox(width: 4),
                    CustomText(
                      detail.accountType == null
                          ? '—'
                          : detail.accountType == AccountType.RESIDENTIAL
                          ? context.tr(LocaleKeys.serviceTypeHousehold)
                          : context.tr(LocaleKeys.serviceTypeCommercial),
                      style: const TextStyle(
                        fontSize: 12,
                        color: cardTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
