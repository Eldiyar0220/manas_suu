import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingsHeaderTitleWidget(title: 'Язык интерфейса'),
          const SizedBox(height: 16),
          SettingsSelectItemWidget(
            value: 'kg',
            groupValue: selectedLanguage,
            title: 'Кыргызча',
            onTap: () => setState(() => selectedLanguage = 'kg'),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            value: 'ru',
            groupValue: selectedLanguage,
            title: 'Русский',
            onTap: () => setState(() => selectedLanguage = 'ru'),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            value: 'en',
            groupValue: selectedLanguage,
            title: 'English',
            onTap: () => setState(() => selectedLanguage = 'en'),
          ),
        ],
      ),
    );
  }
}
