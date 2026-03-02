import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

final class PaymentDialogs {
  const PaymentDialogs._();

  static Future<void> showPaymentSuccess(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final isDark = Theme.of(dialogContext).brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
        final textColor = isDark ? Colors.white : const Color(0xFF1D1D1F);
        final subTextColor = isDark ? Colors.white70 : Colors.black54;

        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor.withValues(alpha: 0.15),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppColors.mainColor,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  context.tr(LocaleKeys.paymentSuccessTitle),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: textColor),
                ),
                const SizedBox(height: 6),
                CustomText(
                  context.tr(LocaleKeys.paymentSuccessMessage),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: subTextColor, height: 1.4),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                                    child: CustomText(
                                      context.tr(LocaleKeys.okButton),
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
