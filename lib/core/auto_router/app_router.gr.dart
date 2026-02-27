// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:manas_suu_app/app/components/app_pdf_viewer_page.dart' as _i1;
import 'package:manas_suu_app/feature/bottom_navigation/bottom_navigation_page.dart'
    as _i2;
import 'package:manas_suu_app/feature/contacts/presentation/pages/contacts_page.dart'
    as _i3;
import 'package:manas_suu_app/feature/history/data/models/history_response.dart'
    as _i13;
import 'package:manas_suu_app/feature/history/presentation/page/main_history_page.dart'
    as _i5;
import 'package:manas_suu_app/feature/history/presentation/page/sub_pages/history_charges_detail_page.dart'
    as _i14;
import 'package:manas_suu_app/feature/main/presentation/pages/main_page.dart'
    as _i6;
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/main_add_user_account_page.dart'
    as _i4;
import 'package:manas_suu_app/feature/notifications/presentation/pages/notifications_page.dart'
    as _i7;
import 'package:manas_suu_app/feature/scanner/presentation/pages/scanner_page.dart'
    as _i8;
import 'package:manas_suu_app/feature/settings/presentation/pages/settings_page.dart'
    as _i9;
import 'package:manas_suu_app/feature/splash/presentation/pages/splash_page.dart'
    as _i10;

/// generated route for
/// [_i1.AppPdfviewerPage]
class AppPdfviewerRoute extends _i11.PageRouteInfo<AppPdfviewerRouteArgs> {
  AppPdfviewerRoute({
    _i12.Key? key,
    String? base64Pdf,
    String? filePath,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         AppPdfviewerRoute.name,
         args: AppPdfviewerRouteArgs(
           key: key,
           base64Pdf: base64Pdf,
           filePath: filePath,
         ),
         initialChildren: children,
       );

  static const String name = 'AppPdfviewerRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppPdfviewerRouteArgs>();
      return _i1.AppPdfviewerPage(
        key: args.key,
        base64Pdf: args.base64Pdf,
        filePath: args.filePath,
      );
    },
  );
}

class AppPdfviewerRouteArgs {
  const AppPdfviewerRouteArgs({this.key, this.base64Pdf, this.filePath});

  final _i12.Key? key;

  final String? base64Pdf;

  final String? filePath;

  @override
  String toString() {
    return 'AppPdfviewerRouteArgs{key: $key, base64Pdf: $base64Pdf, filePath: $filePath}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppPdfviewerRouteArgs) return false;
    return key == other.key &&
        base64Pdf == other.base64Pdf &&
        filePath == other.filePath;
  }

  @override
  int get hashCode => Object.hash(key, base64Pdf, filePath);
}

/// generated route for
/// [_i2.BottomNavigationPage]
class BottomNavigationRoute extends _i11.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i11.PageRouteInfo>? children})
    : super(BottomNavigationRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.BottomNavigationPage();
    },
  );
}

/// generated route for
/// [_i3.ContactsPage]
class ContactsRoute extends _i11.PageRouteInfo<void> {
  const ContactsRoute({List<_i11.PageRouteInfo>? children})
    : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.ContactsPage();
    },
  );
}

/// generated route for
/// [_i4.MainAddUserAccountPage]
class MainAddUserAccountRoute extends _i11.PageRouteInfo<void> {
  const MainAddUserAccountRoute({List<_i11.PageRouteInfo>? children})
    : super(MainAddUserAccountRoute.name, initialChildren: children);

  static const String name = 'MainAddUserAccountRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainAddUserAccountPage();
    },
  );
}

/// generated route for
/// [_i5.MainHistoryPage]
class MainHistoryRoute extends _i11.PageRouteInfo<MainHistoryRouteArgs> {
  MainHistoryRoute({
    _i12.Key? key,
    required _i13.HistoryData model,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         MainHistoryRoute.name,
         args: MainHistoryRouteArgs(key: key, model: model),
         initialChildren: children,
       );

  static const String name = 'MainHistoryRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainHistoryRouteArgs>();
      return _i5.MainHistoryPage(key: args.key, model: args.model);
    },
  );
}

class MainHistoryRouteArgs {
  const MainHistoryRouteArgs({this.key, required this.model});

  final _i12.Key? key;

  final _i13.HistoryData model;

  @override
  String toString() {
    return 'MainHistoryRouteArgs{key: $key, model: $model}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainHistoryRouteArgs) return false;
    return key == other.key && model == other.model;
  }

  @override
  int get hashCode => key.hashCode ^ model.hashCode;
}

/// generated route for
/// [_i14.HistoryChargesDetailPage]
class HistoryChargesDetailRoute
    extends _i11.PageRouteInfo<HistoryChargesDetailRouteArgs> {
  HistoryChargesDetailRoute({
    _i12.Key? key,
    required _i13.HistoryModel period,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         HistoryChargesDetailRoute.name,
         args: HistoryChargesDetailRouteArgs(key: key, period: period),
         initialChildren: children,
       );

  static const String name = 'HistoryChargesDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HistoryChargesDetailRouteArgs>();
      return _i14.HistoryChargesDetailPage(key: args.key, period: args.period);
    },
  );
}

class HistoryChargesDetailRouteArgs {
  const HistoryChargesDetailRouteArgs({this.key, required this.period});

  final _i12.Key? key;

  final _i13.HistoryModel period;

  @override
  String toString() {
    return 'HistoryChargesDetailRouteArgs{key: $key, period: $period}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HistoryChargesDetailRouteArgs) return false;
    return key == other.key && period == other.period;
  }

  @override
  int get hashCode => key.hashCode ^ period.hashCode;
}

/// generated route for
/// [_i6.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.MainPage();
    },
  );
}

/// generated route for
/// [_i7.NotificationsPage]
class NotificationsRoute extends _i11.PageRouteInfo<void> {
  const NotificationsRoute({List<_i11.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.NotificationsPage();
    },
  );
}

/// generated route for
/// [_i8.ScannerPage]
class ScannerRoute extends _i11.PageRouteInfo<void> {
  const ScannerRoute({List<_i11.PageRouteInfo>? children})
    : super(ScannerRoute.name, initialChildren: children);

  static const String name = 'ScannerRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.ScannerPage();
    },
  );
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute({List<_i11.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SettingsPage();
    },
  );
}

/// generated route for
/// [_i10.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i12.Key? key,
    double progress = 1,
    String version = '1.0.11+11',
    List<_i11.PageRouteInfo>? children,
  }) : super(
         SplashRoute.name,
         args: SplashRouteArgs(key: key, progress: progress, version: version),
         initialChildren: children,
       );

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i11.WrappedRoute(
        child: _i10.SplashPage(
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

  final _i12.Key? key;

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
