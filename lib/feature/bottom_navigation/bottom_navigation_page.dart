import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';
import 'package:manas_suu_app/feature/bottom_navigation/bottom_navigator_items.dart';

@RoutePage()
class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      routes: const [
        MainRoute(),
        NewsRoute(),
        ContactsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) =>
          BottomNavigatorItem(tabsRouter: tabsRouter, initialIndex: 0),
    );
  }
}
