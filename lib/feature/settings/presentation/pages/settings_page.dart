import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_language_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_notification_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/widgets/settings_theme_body_widget.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.tr(LocaleKeys.bottomNavText4), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(context.tr(LocaleKeys.settingApp), style: TextStyle(color: context.theme.textWhiteBlackColor)),
            const SizedBox(height: 24),
            SettingsNotificationAndVersionWidget(
              icon: Icons.notifications,
              title: context.tr(LocaleKeys.notifications),

              subtitle: context.tr(LocaleKeys.seeAllNotifications),
            ),
            const SizedBox(height: 24),
            SettingsThemeBodyWidget(),
            const SizedBox(height: 24),
            SettingsLanguageWidget(),
            const SizedBox(height: 24),
            SettingsNotificationAndVersionWidget(
              icon: Icons.info_outline,
              title: context.tr(LocaleKeys.aboutApp),

              subtitle: '1.0.11+11',
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(context.tr(LocaleKeys.pravaSecured), style: TextStyle(color: Colors.white38)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
