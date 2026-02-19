import 'package:auto_route/auto_route.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<CupertinoRoute> get routes => [
    CupertinoRoute(page: SplashRoute.page, initial: true),
    CupertinoRoute(
      page: BottomNavigationRoute.page,
      children: [
        CupertinoRoute(page: MainRoute.page),
        CupertinoRoute(page: ContactsRoute.page),
        CupertinoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
