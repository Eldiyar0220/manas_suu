import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/components/app_bouncing_animation_wrapper.dart';
import 'package:manas_suu_app/app/components/app_slide_animations_wirapper.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_button_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_header_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_info_contaiiner_widget.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final controller = TextEditingController();
  late Animation<double> header;
  late Animation<double> button;
  late Animation<double> info;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    header = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    button = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );

    info = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.tr(LocaleKeys.mainPageTitle),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              AppBouncingAnimationWrapper(MainHeaderWalletWidget()),
              AppSlideAnimationWrapper(header, MainHeaderWidget()),
              const SizedBox(height: 28),
              AppSlideAnimationWrapper(button, MainButtonWidget()),
              const SizedBox(height: 24),
              AppSlideAnimationWrapper(info, MainInfoContainerWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
