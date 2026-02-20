import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class MainInfoContainerWidget extends StatelessWidget {
  const MainInfoContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade100),
        color: AppColors.mainColor.withValues(alpha: 0.05),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFF4CAF50),
            child: Icon(Icons.help_outline, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text(
            context.tr(LocaleKeys.mainPageWhereToFind),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2E7D32), fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            context.tr(LocaleKeys.mainPageShowed),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
