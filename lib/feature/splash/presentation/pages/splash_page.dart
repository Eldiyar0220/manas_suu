import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:manas_suu_app/app/constants/app_images.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';
import 'package:manas_suu_app/feature/splash/presentation/bloc/splash_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget implements AutoRouteWrapper {
  const SplashPage({super.key, this.progress = 1, this.version = '1.0.11+11'});

  final double progress; // 0.0 → 1.0
  final String version;
  @override
  State<SplashPage> createState() => _SplashPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => GetIt.I<SplashBloc>()..add(ToSplashEvent()), child: this);
  }
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween<double>(
      begin: 0.0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.delayed(const Duration(seconds: 2), () {
        context.router.pushAndRemoveUntil(BottomNavigationRoute());
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final percent = (_animation.value * 100).toInt();
              return Column(
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
                      boxShadow: [
                        BoxShadow(color: Colors.green.withValues(alpha: 0.3), blurRadius: 30, spreadRadius: 5),
                      ],
                    ),
                    child: Image.asset(AppImages.logo, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 24),

                  /// TITLE
                  Text(
                    context.tr(LocaleKeys.splashTitle),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textWhiteBlackColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr(LocaleKeys.splashSubTitle),
                    style: TextStyle(fontSize: 14, color: context.theme.textWhiteBlackColor),
                  ),
                  const Spacer(),

                  /// PROGRESS BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: _animation.value,
                            minHeight: 6,
                            backgroundColor: Colors.white10,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF4CAF50)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          context.tr(LocaleKeys.configurationLoading),
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
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
