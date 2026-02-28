import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manas_suu_app/app/components/app_button_green_widget.dart';
import 'package:manas_suu_app/app/components/app_slide_animations_wirapper.dart';
import 'package:manas_suu_app/app/components/app_text_field_widget.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/main/presentation/bloc/main_cubit.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/user_account_header_widget.dart';
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/widgets/user_account_info_widget.dart';
import 'package:manas_suu_app/feature/settings/presentation/bloc/theme/cubit/theme_cubit.dart';

@RoutePage()
class MainAddUserAccountPage extends StatefulWidget {
  const MainAddUserAccountPage({super.key, this.isAddedAccount = false});
  final bool isAddedAccount;

  @override
  State<MainAddUserAccountPage> createState() => _MainAddUserAccountPageState();
}

class _MainAddUserAccountPageState extends State<MainAddUserAccountPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final controller = TextEditingController();
  late Animation<double> header;
  late Animation<double> textField;
  late Animation<double> button;
  late Animation<double> info;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    header = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    textField = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );

    button = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
    );

    info = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (state.status == MainStateStatus.AUTHSUCCESS) {
          context.read<MainCubit>().getMyAccounts();
          context.router.pop();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: context.theme.userAccountBackground ?? [],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: context.router.pop,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: context.watch<ThemeCubit>().state.isDarkMode
                              ? Colors.white10
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: context.watch<ThemeCubit>().state.isDarkMode
                              ? Colors.white
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                  AppSlideAnimationWrapper(
                    header,
                    const UserAccountHeaderWidget(),
                  ),
                  const SizedBox(height: 16),
                  AppSlideAnimationWrapper(
                    textField,
                    AppTextFieldWidget(
                      controller: controller,
                      onQrTap: () async {
                        final result = await context.router.push<String>(
                          const ScannerRoute(),
                        );
                        if (result != null && mounted) {
                          controller.text = result;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppSlideAnimationWrapper(
                    button,
                    AppButtonGreenWidget(
                      controller: controller,
                      isAddedAccount: widget.isAddedAccount,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppSlideAnimationWrapper(info, const UserAccountInfoWidget()),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
