import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class DetailControllerCardWidget extends StatelessWidget {
  const DetailControllerCardWidget(this.name, this.phone, {super.key});

  final String name;
  final String? phone;

  Future<void> _call(BuildContext context, String phoneNumber) async {
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(RegExp(r'\s'), ''),
    );
    if (await url_launcher.canLaunchUrl(uri)) {
      await url_launcher.launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardBackgroundWhiteBlackColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mainColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                context.tr(LocaleKeys.controller),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textWhiteBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CustomText(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.textWhiteBlackColor,
                  ),
                ),
              ),
              if (phone != null && phone!.isNotEmpty) ...[
                CustomText(
                  phone!,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.textWhiteBlackColor,
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: () => _call(context, phone!),
                    borderRadius: BorderRadius.circular(24),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.phone, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
