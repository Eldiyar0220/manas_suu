import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';
import 'package:manas_suu_app/feature/splash/presentation/bloc/splash_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  const SplashPage({super.key, this.progress = 0.5, this.version = '1.0.11+11'});

  final double progress; // 0.0 → 1.0
  final String version;
  @override
  State<SplashPage> createState() => _SplashPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => GetIt.I<SplashBloc>()..add(ToSplashEvent()), child: this);
  }
}

class _SplashPageState extends State<SplashPage> {
  int percent = 0;

  @override
  void initState() {
    super.initState();
    percent = (widget.progress * 100).toInt();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.delayed(Duration(seconds: 2), () {
        context.router.pushAndRemoveUntil(BottomNavigationRoute());
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: context.watch<ThemeCubit>().state.isDarkMode
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0E1A14), Color(0xFF0A120F)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            : BoxDecoration(color: Colors.green.withValues(alpha: 0.1)),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),

              /// LOGO
              Container(
                width: 140,
                height: 140,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [BoxShadow(color: Colors.green.withValues(alpha: 0.3), blurRadius: 30, spreadRadius: 5)],
                ),
                child: Image.asset('assets/logo.png', fit: BoxFit.contain),
              ),

              const SizedBox(height: 24),

              /// TITLE
              Text(
                'Ош-Тазалык',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: context.theme.textWhiteBlackColor),
              ),

              const SizedBox(height: 8),

              Text('Жеке эсептерди башкаруу', style: TextStyle(fontSize: 14, color: context.theme.textWhiteBlackColor)),

              const Spacer(),

              /// PROGRESS BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: widget.progress,
                        minHeight: 6,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Конфигурацияны жүктөө...',
                      style: TextStyle(color: context.theme.textWhiteBlackColor, fontSize: 13),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '$percent%',
                      style: const TextStyle(color: Color(0xFF4CAF50), fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// VERSION
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white10),
                child: Text(
                  'Версия ${widget.version}',
                  style: TextStyle(color: context.theme.textWhiteBlackColor, fontSize: 12),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                '© 2026 Бардык укуктар корголгон',
                style: TextStyle(color: context.theme.textWhiteBlackColor, fontSize: 11),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
