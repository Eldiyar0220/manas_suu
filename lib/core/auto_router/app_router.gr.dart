// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:manas_suu_app/feature/bottom_navigation/bottom_navigation_page.dart'
    as _i1;
import 'package:manas_suu_app/feature/contacts/presentation/pages/contacts_page.dart'
    as _i2;
import 'package:manas_suu_app/feature/main/presentation/pages/main_page.dart'
    as _i4;
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/main_add_user_account_page.dart'
    as _i3;
import 'package:manas_suu_app/feature/notifications/presentation/pages/notifications_page.dart'
    as _i5;
import 'package:manas_suu_app/feature/scanner/presentation/pages/scanner_page.dart'
    as _i6;
import 'package:manas_suu_app/feature/settings/presentation/pages/settings_page.dart'
    as _i7;
import 'package:manas_suu_app/feature/splash/presentation/pages/splash_page.dart'
    as _i8;

/// generated route for
/// [_i1.BottomNavigationPage]
class BottomNavigationRoute extends _i9.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i9.PageRouteInfo>? children})
    : super(BottomNavigationRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavigationPage();
    },
  );
}

/// generated route for
/// [_i2.ContactsPage]
class ContactsRoute extends _i9.PageRouteInfo<void> {
  const ContactsRoute({List<_i9.PageRouteInfo>? children})
    : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.ContactsPage();
    },
  );
}

/// generated route for
/// [_i3.MainAddUserAccountPage]
class MainAddUserAccountRoute extends _i9.PageRouteInfo<void> {
  const MainAddUserAccountRoute({List<_i9.PageRouteInfo>? children})
    : super(MainAddUserAccountRoute.name, initialChildren: children);

  static const String name = 'MainAddUserAccountRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainAddUserAccountPage();
    },
  );
}

/// generated route for
/// [_i4.MainPage]
class MainRoute extends _i9.PageRouteInfo<void> {
  const MainRoute({List<_i9.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainPage();
    },
  );
}

/// generated route for
/// [_i5.NotificationsPage]
class NotificationsRoute extends _i9.PageRouteInfo<void> {
  const NotificationsRoute({List<_i9.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.NotificationsPage();
    },
  );
}

/// generated route for
/// [_i6.ScannerPage]
class ScannerRoute extends _i9.PageRouteInfo<void> {
  const ScannerRoute({List<_i9.PageRouteInfo>? children})
    : super(ScannerRoute.name, initialChildren: children);

  static const String name = 'ScannerRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.ScannerPage();
    },
  );
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsPage();
    },
  );
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i10.Key? key,
    double progress = 1,
    String version = '1.0.11+11',
    List<_i9.PageRouteInfo>? children,
  }) : super(
         SplashRoute.name,
         args: SplashRouteArgs(key: key, progress: progress, version: version),
         initialChildren: children,
       );

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i9.WrappedRoute(
        child: _i8.SplashPage(
          key: args.key,
          progress: args.progress,
          version: args.version,
        ),
      );
    },
  );
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.key,
    this.progress = 1,
    this.version = '1.0.11+11',
  });

  final _i10.Key? key;

  final double progress;

  final String version;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key, progress: $progress, version: $version}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SplashRouteArgs) return false;
    return key == other.key &&
        progress == other.progress &&
        version == other.version;
  }

  @override
  int get hashCode => key.hashCode ^ progress.hashCode ^ version.hashCode;
}
