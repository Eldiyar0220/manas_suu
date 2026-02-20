// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/langs/lang_gen/locale_keys.g.dart';
import 'package:manas_suu_app/app/theme/app_colors/app_colors.dart';

class BottomNavigatorItem extends StatefulWidget {
  const BottomNavigatorItem({super.key, required this.tabsRouter, required this.initialIndex});
  final TabsRouter tabsRouter;
  final int initialIndex;

  @override
  State<BottomNavigatorItem> createState() => _BottomNavigatorItemState();
}

class _BottomNavigatorItemState extends State<BottomNavigatorItem> {
  int? _initialIndex;

  @override
  void initState() {
    super.initState();
    _initialIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _initialIndex ?? widget.tabsRouter.activeIndex,
      selectedItemColor: AppColors.bottomNavigationColor,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => widget.tabsRouter.setActiveIndex(index),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: context.tr(LocaleKeys.bottomNavText1)),
        BottomNavigationBarItem(
          icon: Icon(Icons.perm_contact_calendar_outlined),
          label: context.tr(LocaleKeys.bottomNavText3),
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: context.tr(LocaleKeys.bottomNavText4)),
      ],
    );
  }
}
