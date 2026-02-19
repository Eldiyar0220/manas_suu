import 'package:flutter/material.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_header_title_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_select_item_widget.dart';

class SettingsThemeBodyWidget extends StatefulWidget {
  const SettingsThemeBodyWidget({super.key});

  @override
  State<SettingsThemeBodyWidget> createState() =>
      _SettingsThemeBodyWidgetState();
}

class _SettingsThemeBodyWidgetState extends State<SettingsThemeBodyWidget> {
  String selectedTheme = 'system';

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
          const SettingsHeaderTitleWidget(title: 'Тема приложения'),
          const SizedBox(height: 16),
          SettingsSelectItemWidget(
            value: 'light',
            groupValue: selectedTheme,
            title: 'Светлая',
            onTap: () => setState(() => selectedTheme = 'light'),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            value: 'dark',
            groupValue: selectedTheme,
            title: 'Темная',
            onTap: () => setState(() => selectedTheme = 'dark'),
          ),
          const SizedBox(height: 12),
          SettingsSelectItemWidget(
            value: 'system',
            groupValue: selectedTheme,
            title: 'Системная',
            onTap: () => setState(() => selectedTheme = 'system'),
          ),
        ],
      ),
    );
  }
}
