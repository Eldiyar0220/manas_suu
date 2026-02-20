import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class SettingsNotificationAndVersionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SettingsNotificationAndVersionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.theme.cardBackgroundWhiteBlackColor,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.mainColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: context.theme.textWhiteBlackColor),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: context.theme.textWhiteBlackColor)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: context.theme.textWhiteBlackColor),
        ],
      ),
    );
  }
}
