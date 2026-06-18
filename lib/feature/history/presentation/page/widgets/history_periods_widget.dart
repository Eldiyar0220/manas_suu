import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/history/data/models/history_response.dart';
import 'package:manas_suu_app/feature/history/presentation/bloc/history_bloc.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

class HistoryPeriodsWidget extends StatelessWidget {
  const HistoryPeriodsWidget({super.key, required this.model});
  final HistoryData model;
  @override
  Widget build(BuildContext context) {
    final periods = model.periods ?? [];
    return Column(
      children: [
        if (periods.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Center(
              child: CustomText(
                context.tr(LocaleKeys.historyNoData),
                style: TextStyle(
                  color: context.theme.textSecondaryWhiteBlackColor,
                  fontSize: 14,
                ),
              ),
            ),
          )
        else
          AnimationLimiter(
            child: Column(
              children: List.generate(periods.length, (index) {
                final item = periods[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: 250,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: _HistoryMonthCard(item: item),
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}

class _HistoryMonthCard extends StatefulWidget {
  const _HistoryMonthCard({required this.item});

  final HistoryModel item;

  @override
  State<_HistoryMonthCard> createState() => _HistoryMonthCardState();
}

class _HistoryMonthCardState extends State<_HistoryMonthCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.theme.cardBackgroundWhiteBlackColor!,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: context.watch<ThemeCubit>().state.isDarkMode
                ? Colors.black.withValues(alpha: 0.7)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: _isExpanded,
          iconColor: context.theme.iconSecondaryWhiteBlackColor!,
          collapsedIconColor: context.theme.iconSecondaryWhiteBlackColor!,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          onExpansionChanged: (expanded) {
            setState(() => _isExpanded = expanded);
          },
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.theme.historyIconContainerBackground!,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              size: 18,
              color: context.watch<ThemeCubit>().state.isDarkMode
                  ? Colors.white
                  : AppColors.mainColor,
            ),
          ),
          title: CustomText(
            widget.item.periodLabel ?? '—',
            style: TextStyle(
              color: context.theme.textWhiteBlackColor!,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: CustomText(
              '${(widget.item.closingBalance ?? 0).toStringAsFixed(2)} сом',
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          children: [
            const SizedBox(height: 8),
            _HistoryDetailRow(
              label: context.tr(LocaleKeys.historyPeriodStart),
              value:
                  '${(widget.item.openingBalance ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
            ),
            const SizedBox(height: 4),
            _HistoryDetailRow(
              label: context.tr(LocaleKeys.historyAccrued),
              value:
                  '${(widget.item.accrued ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
              valueColor: Colors.orangeAccent,
            ),
            const SizedBox(height: 4),
            _HistoryDetailRow(
              label: context.tr(LocaleKeys.historyPaid),
              value:
                  '${(widget.item.paid ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
              valueColor: const Color(0xFF4CAF50),
            ),
            const SizedBox(height: 4),
            _HistoryDetailRow(
              label: context.tr(LocaleKeys.historyPeriodEnd),
              value:
                  '${(widget.item.closingBalance ?? 0).toStringAsFixed(2)} ${context.tr(LocaleKeys.currencySom)}',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _HistoryActionButton(
                    label: context.tr(LocaleKeys.historyCharges),
                    color: const Color(0xFFFF9800),
                    onTap: () {
                      context.router.push(
                        HistoryChargesDetailRoute(period: widget.item),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _HistoryActionButton(
                    label: context.tr(LocaleKeys.printInvoice),
                    color: const Color(0xFF4CAF50),
                    onTap: () {
                      final accountId = context
                          .read<MainCubit>()
                          .state
                          .selectedAccount
                          ?.id;
                      if (accountId == null) return;
                      final year =
                          widget.item.periodYear ?? DateTime.now().year;
                      final month =
                          widget.item.periodMonth ?? DateTime.now().month;
                      context.read<HistoryBloc>().add(
                        GetHistoryCheckEvent(
                          accountId: accountId,
                          year: year,
                          month: month,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryDetailRow extends StatelessWidget {
  const _HistoryDetailRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final baseLabelColor = context.theme.textSecondaryWhiteBlackColor!;
    final baseValueColor = context.theme.textWhiteBlackColor!;

    return Row(
      children: [
        Expanded(
          child: CustomText(
            label,
            style: TextStyle(color: baseLabelColor, fontSize: 13),
          ),
        ),
        CustomText(
          value,
          style: TextStyle(color: valueColor ?? baseValueColor, fontSize: 13),
        ),
      ],
    );
  }
}

class _HistoryActionButton extends StatelessWidget {
  const _HistoryActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: CustomText(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
