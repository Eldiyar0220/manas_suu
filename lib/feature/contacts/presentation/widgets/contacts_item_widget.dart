import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ContactItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String? launchUrl;

  const ContactItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.launchUrl,
  });

  Future<void> _onTap(BuildContext context) async {
    if (launchUrl == null) return;
    final uri = Uri.parse(launchUrl!);
    final scheme = uri.scheme.toLowerCase();
    final isPhone = scheme == 'tel';
    final isEmail = scheme == 'mailto';
    final isWeb = scheme == 'https' || scheme == 'http';
    final isGeo = scheme == 'geo';
    final skipCanLaunch = isPhone || isEmail || isWeb || isGeo;
    final canOpen = skipCanLaunch || await url_launcher.canLaunchUrl(uri);
    if (canOpen) {
      final mode = isPhone ? url_launcher.LaunchMode.platformDefault : url_launcher.LaunchMode.externalApplication;
      await url_launcher.launchUrl(uri, mode: mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.theme.cardBackgroundWhiteBlackColor,
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color.withValues(alpha: 0.15),
              boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 20)],
            ),
            child: Icon(Icons.info, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: context.theme.textWhiteBlackColor),
                ),
                const SizedBox(height: 6),
                CustomText(subtitle, style: TextStyle(color: context.theme.textWhiteBlackColor)),
              ],
            ),
          ),
          if (launchUrl != null) Icon(Icons.chevron_right, color: context.theme.textWhiteBlackColor),
        ],
      ),
    );

    if (launchUrl != null) {
      return InkWell(onTap: () => _onTap(context), borderRadius: BorderRadius.circular(20), child: child);
    }
    return child;
  }
}
