import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_text_scaler.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
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
        title: CustomText(
          context.tr(LocaleKeys.bottomNavText4),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomText(context.tr(LocaleKeys.settingApp), style: TextStyle(color: context.theme.textWhiteBlackColor)),
            const SizedBox(height: 24),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => context.router.push(NotificationsRoute()),
              child: SettingsNotificationAndVersionWidget(
                icon: Icons.notifications,
                title: context.tr(LocaleKeys.notifications),
              ),
            ),
            const SizedBox(height: 24),
            SettingsThemeBodyWidget(),
            const SizedBox(height: 24),
            SettingsLanguageWidget(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
