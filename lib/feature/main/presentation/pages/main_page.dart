import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_button_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_header_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/widgets/main_info_contaiiner_widget.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Убрать колор, Султан сделает тему
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F7F6),
        centerTitle: true,
        title: Text(
          context.tr(LocaleKeys.mainPageTitle),
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.black87),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              MainHeaderWidget(),
              const SizedBox(height: 28),
              MainButtonWidget(),
              const SizedBox(height: 24),
              MainInfoContainerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
