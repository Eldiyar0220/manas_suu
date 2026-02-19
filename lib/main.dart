import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:manas_suu_app/app/langs/lang_gen/codegen_loader.g.dart';
import 'package:manas_suu_app/app/theme/app_theme.dart';
import 'package:manas_suu_app/core/auto_router/app_router.dart';
import 'package:manas_suu_app/core/injectable/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment: AppEnv.prod);
  runApp(
    EasyLocalization(
      path: 'lib/langs',
      ignorePluralRules: false,
      supportedLocales: const [Locale('ru', 'RU')],
      fallbackLocale: const Locale('ru', 'RU'),
      assetLoader: const CodegenLoader(),
      child: ManasSuuApp(),
    ),
  );
}

class ManasSuuApp extends StatefulWidget {
  const ManasSuuApp({super.key});
  @override
  State<ManasSuuApp> createState() => _ManasSuuAppState();
}

class _ManasSuuAppState extends State<ManasSuuApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MegaPay',
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
      theme: AppThemes.isLightTheme,
    );
  }
}
