import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';

class ChargesHeaderCardWidget extends StatelessWidget {
  const ChargesHeaderCardWidget({
    super.key,
    required this.periodLabel,
    required this.cardColor,
    required this.textColor,
    required this.subTextColor,
    required this.iconContainerBg,
    required this.accentGreen,
  });

  final String periodLabel;
  final Color cardColor;
  final Color textColor;
  final Color subTextColor;
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
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconContainerBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              color: accentGreen,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr(LocaleKeys.historyPeriod),
                  style: TextStyle(fontSize: 12, color: subTextColor),
                ),
                const SizedBox(height: 2),
                Text(
                  periodLabel,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
