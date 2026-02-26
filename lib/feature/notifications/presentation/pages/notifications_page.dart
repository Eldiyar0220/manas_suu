import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

@RoutePage()
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
    final iconBgColor = isDark ? Colors.blue.shade900.withValues(alpha: 0.4) : Colors.blue.shade50;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => context.router.maybePop(),
        ),
        title: Text(
          context.tr(LocaleKeys.notifications),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_none,
                  size: 48,
                  color: Colors.blue.shade400,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                context.tr(LocaleKeys.noNotifications),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                context.tr(LocaleKeys.noNotificationsDesc),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: subTextColor,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
