import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class MainHeaderWidget extends StatelessWidget {
  const MainHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        

        const SizedBox(height: 24),

        CustomText(
          context.tr(LocaleKeys.mainPageNoCheck),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF43A047),
          ),
        ),

        const SizedBox(height: 12),

        CustomText(
          context.tr(LocaleKeys.mainPageNoCheckDesc),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
      ],
    );
  }
}

class MainHeaderWalletWidget extends StatelessWidget {
  const MainHeaderWalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: const Color(0xFF4CAF50), width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withValues(alpha: 0.25),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        size: 60,
        color: Color(0xFF4CAF50),
      ),
    );
  }
}
