import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:manas_suu_app/app/langs/lang_gen/codegen_loader.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/app/theme/app_theme.dart';
import 'package:manas_suu_app/core/auto_router/app_router.dart';
import 'package:manas_suu_app/core/injectable/injectable.dart';
import 'package:manas_suu_app/core/notifications/local_notifications_service.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('data-unique: message: $message ');

  if (message.notification == null) {
    final localNotifications = LocalNotificationsService();
    await localNotifications.initialize();
    await localNotifications.showNotificationFromRemoteMessage(message);
  }
}

void _configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorColor = AppColors.mainColor
    ..indicatorSize = 45.0
    ..radius = 12.0
    ..backgroundColor = const Color(0xFF2D2D2D)
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  await configureDependencies(environment: AppEnv.dev);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final localNotifications = GetIt.I<LocalNotificationsService>();
  await localNotifications.initialize();
  _configEasyLoading();
  runApp(
    EasyLocalization(
      path: 'lib/app/langs/lang_gen',
      ignorePluralRules: false,
      supportedLocales: const [Locale('ru', 'RU'), Locale('ky', 'KY'), Locale('en', 'US')],
      fallbackLocale: const Locale('ru', 'RU'),
      assetLoader: const CodegenLoader(),
      child: ManasSuuApp(localNotifications: localNotifications),
    ),
  );
}

class ManasSuuApp extends StatefulWidget {
  const ManasSuuApp({super.key, required this.localNotifications});
  final LocalNotificationsService localNotifications;

  @override
  State<ManasSuuApp> createState() => _ManasSuuAppState();
}

class _ManasSuuAppState extends State<ManasSuuApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
    _initializeFirebaseMessaging();
  }

  Future<void> _initializeFirebaseMessaging() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.getInitialMessage();

      final settings = await messaging.requestPermission(alert: true, badge: true, sound: true);

      log('Permission: ${settings.authorizationStatus}');

      final token = await messaging.getToken();
      log('FCM Token: $token');

      FirebaseMessaging.onMessage.listen((message) {
        ///TODO soon add  message.notification == null
        // if (message.notification == null) {
        widget.localNotifications.showNotificationFromRemoteMessage(message);
        // }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        //deeplinke kerek
      });
    } catch (e, st) {
      log('$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<ThemeCubit>()..init()),
        BlocProvider(create: (context) => GetIt.I<MainCubit>()),
      ],
      child: Builder(
        builder: (context) => MaterialApp.router(
          title: 'Манас Тазалык',
          builder: EasyLoading.init(),
          locale: context.locale,
          routerConfig: _appRouter.config(),
          localizationsDelegates: [
            ...context.localizationDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: context.supportedLocales,
          darkTheme: AppThemes.mainThemeDark,
          themeMode: context.watch<ThemeCubit>().state.themeMode,
          theme: AppThemes.isLightTheme,
        ),
      ),
    );
  }
}
