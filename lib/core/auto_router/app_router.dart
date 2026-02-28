import 'package:auto_route/auto_route.dart';
import 'package:manas_suu_app/app/constants/navigator_key.dart';
import 'package:manas_suu_app/core/auto_router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: navigatorKey);

  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<CupertinoRoute> get routes => [
    CupertinoRoute(page: SplashRoute.page, initial: true),
    CupertinoRoute(page: MainAddUserAccountRoute.page),
    CupertinoRoute(page: NotificationsRoute.page),
    CupertinoRoute(page: NotificationDetailRoute.page),
    CupertinoRoute(page: MainHistoryRoute.page),
    CupertinoRoute(page: ScannerRoute.page),
    CupertinoRoute(page: AppPdfviewerRoute.page),
    CupertinoRoute(page: HistoryChargesDetailRoute.page),
    CupertinoRoute(page: AccountDetailRoute.page),
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
