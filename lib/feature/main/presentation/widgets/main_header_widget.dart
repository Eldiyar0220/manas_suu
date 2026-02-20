import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class MainHeaderWidget extends StatelessWidget {
  const MainHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF4CAF50), width: 3),
            boxShadow: [BoxShadow(color: AppColors.mainColor.withValues(alpha: 0.25), blurRadius: 30, spreadRadius: 5)],
          ),
          child: const Icon(Icons.account_balance_wallet, size: 60, color: Color(0xFF4CAF50)),
        ),

        const SizedBox(height: 24),

        Text(
          context.tr(LocaleKeys.mainPageNoCheck),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF43A047)),
        ),

        const SizedBox(height: 12),

        Text(
          context.tr(LocaleKeys.mainPageNoCheckDesc),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
        ),
      ],
    );
  }
}
