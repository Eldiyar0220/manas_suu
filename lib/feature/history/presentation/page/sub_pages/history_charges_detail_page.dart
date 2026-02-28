import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';
import 'package:manas_suu_app/feature/history/presentation/page/sub_pages/widgets/charges_card_widget.dart';
import 'package:manas_suu_app/feature/history/presentation/page/sub_pages/widgets/charges_header_card_widget.dart';

@RoutePage()
class HistoryChargesDetailPage extends StatelessWidget {
  const HistoryChargesDetailPage({super.key, required this.period});

  final HistoryModel period;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.router.maybePop(),
        ),
        centerTitle: true,
        title: CustomText(
          context.tr(LocaleKeys.historyChargesForPeriod),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: context.theme.textWhiteBlackColor!,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChargesHeaderCardWidget(
                periodLabel: period.periodLabel,
                cardColor: context.theme.cardBackgroundWhiteBlackColor!,
                textColor: context.theme.textWhiteBlackColor!,
                subTextColor: context.theme.textSecondaryWhiteBlackColor!,
                iconContainerBg: context.theme.historyIconContainerBackground!,
                accentGreen: AppColors.mainColor,
              ),
              const SizedBox(height: 12),
              ChargesCardWidget(
                services: period.services,
                periodAccrued: period.accrued,
                cardColor: context.theme.cardBackgroundWhiteBlackColor!,
                textColor: context.theme.textWhiteBlackColor!,
                subTextColor: context.theme.textSecondaryWhiteBlackColor!,
                dividerColor: Theme.of(context).dividerColor,
                iconContainerBg: context.theme.historyIconContainerBackground!,
                accentGreen: AppColors.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
