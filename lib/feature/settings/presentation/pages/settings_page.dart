import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_language_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_notification_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_theme_body_widget.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Настройки',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              'Настройте приложение под свои предпочтения',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 24),
            SettingsNotificationAndVersionWidget(
              icon: Icons.notifications,
              title: 'Уведомления',
              subtitle: 'Все уведомления прочитаны',
            ),
            const SizedBox(height: 24),
            SettingsThemeBodyWidget(),
            const SizedBox(height: 24),
            SettingsLanguageWidget(),
            const SizedBox(height: 24),
            SettingsNotificationAndVersionWidget(
              icon: Icons.info_outline,
              title: 'О приложении',
              subtitle: '1.0.11+11',
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                '© 2025 Все права защищены',
                style: TextStyle(color: Colors.white38),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
