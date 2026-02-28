import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class SettingsSelectItemWidget extends StatelessWidget {
  final String value;
  final String groupValue;
  final String title;
  final VoidCallback onTap;
  final String? stringIcon;
  final IconData? icon;

  const SettingsSelectItemWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onTap,
    this.stringIcon,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColors.mainColor : const Color.fromARGB(60, 143, 143, 143)),
          color: isSelected ? AppColors.mainColor.withValues(alpha: 0.15) : context.theme.cardBackgroundWhiteBlackColor,
        ),
        child: Row(
          children: [
            if (stringIcon != null && icon == null)
              Padding(padding: const EdgeInsets.only(right: 8.0), child: CustomText(stringIcon!)),
            if (stringIcon == null && icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon!, color: isSelected ? AppColors.mainColor : context.theme.textWhiteBlackColor),
              ),

            Expanded(
              child: CustomText(
                title,
                style: TextStyle(color: isSelected ? AppColors.mainColor : context.theme.textWhiteBlackColor),
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: AppColors.mainColor),
          ],
        ),
      ),
    );
  }
}
