import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_header_title_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_select_item_widget.dart';

class SettingsLanguageWidget extends StatefulWidget {
  const SettingsLanguageWidget({super.key});

  @override
  State<SettingsLanguageWidget> createState() => _SettingsLanguageWidgetState();
}

class _SettingsLanguageWidgetState extends State<SettingsLanguageWidget> {
  String selectedLanguage = 'ru';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardBackgroundWhiteBlackColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeaderTitleWidget(title: context.tr(LocaleKeys.langInterface), icon: Icons.language),
          const SizedBox(height: 16),
          SettingsSelectItemWidget(
            value: 'kg',
            stringIcon: '🇰🇬',
            groupValue: selectedLanguage,
            title: context.tr(LocaleKeys.langKyrgyz),
            onTap: () => setState(() {
              selectedLanguage = 'kg';
              context.setLocale(Locale('ky', 'KY'));
            }),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            stringIcon: '🇷🇺',
            value: 'ru',
            groupValue: selectedLanguage,
            title: context.tr(LocaleKeys.langRussian),
            onTap: () => setState(() {
              selectedLanguage = 'ru';
              context.setLocale(Locale('ru', 'RU'));
            }),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            stringIcon: '🇺🇸',
            value: 'en',
            groupValue: selectedLanguage,
            title: context.tr(LocaleKeys.langEnglish),
            onTap: () => setState(() {
              selectedLanguage = 'en';
              context.setLocale(Locale('en', 'US'));
            }),
          ),
        ],
      ),
    );
  }
}
