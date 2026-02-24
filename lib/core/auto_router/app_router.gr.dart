// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:manas_suu_app/feature/bottom_navigation/bottom_navigation_page.dart'
    as _i1;
import 'package:manas_suu_app/feature/contacts/presentation/pages/contacts_page.dart'
    as _i2;
import 'package:manas_suu_app/feature/main/presentation/pages/main_page.dart'
    as _i4;
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/main_add_user_account_page.dart'
    as _i3;
import 'package:manas_suu_app/feature/settings/presentation/pages/settings_page.dart'
    as _i5;
import 'package:manas_suu_app/feature/splash/presentation/pages/splash_page.dart'
    as _i6;

/// generated route for
/// [_i1.BottomNavigationPage]
class BottomNavigationRoute extends _i7.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i7.PageRouteInfo>? children})
    : super(BottomNavigationRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavigationPage();
    },
  );
}

/// generated route for
/// [_i2.ContactsPage]
class ContactsRoute extends _i7.PageRouteInfo<void> {
  const ContactsRoute({List<_i7.PageRouteInfo>? children})
    : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.ContactsPage();
    },
  );
}

/// generated route for
/// [_i3.MainAddUserAccountPage]
class MainAddUserAccountRoute extends _i7.PageRouteInfo<void> {
  const MainAddUserAccountRoute({List<_i7.PageRouteInfo>? children})
    : super(MainAddUserAccountRoute.name, initialChildren: children);

  static const String name = 'MainAddUserAccountRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainAddUserAccountPage();
    },
  );
}

/// generated route for
/// [_i4.MainPage]
class MainRoute extends _i7.PageRouteInfo<void> {
  const MainRoute({List<_i7.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainPage();
    },
  );
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsPage();
    },
  );
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i8.Key? key,
    double progress = 1,
    String version = '1.0.11+11',
    List<_i7.PageRouteInfo>? children,
  }) : super(
         SplashRoute.name,
         args: SplashRouteArgs(key: key, progress: progress, version: version),
         initialChildren: children,
       );

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i7.WrappedRoute(
        child: _i6.SplashPage(
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

  final _i8.Key? key;

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
