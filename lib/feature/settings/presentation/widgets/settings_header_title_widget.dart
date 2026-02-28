import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class SettingsHeaderTitleWidget extends StatelessWidget {
  const SettingsHeaderTitleWidget({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon, color: AppColors.mainColor),
          ),
        Flexible(
          child: CustomText(
            title,
            style: const TextStyle(color: AppColors.mainColor, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
