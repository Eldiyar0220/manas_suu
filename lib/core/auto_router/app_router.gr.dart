// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:manas_suu_app/app/components/app_pdf_viewer_page.dart' as _i2;
import 'package:manas_suu_app/feature/bottom_navigation/bottom_navigation_page.dart'
    as _i3;
import 'package:manas_suu_app/feature/contacts/presentation/pages/contacts_page.dart'
    as _i4;
import 'package:manas_suu_app/feature/history/data/models/history_response.dart'
    as _i17;
import 'package:manas_suu_app/feature/history/presentation/page/main_history_page.dart'
    as _i7;
import 'package:manas_suu_app/feature/history/presentation/page/sub_pages/history_charges_detail_page.dart'
    as _i5;
import 'package:manas_suu_app/feature/main/data/models/myaccount/account_detail_response_model.dart'
    as _i16;
import 'package:manas_suu_app/feature/main/presentation/pages/main_page.dart'
    as _i8;
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/account_detail_page.dart'
    as _i1;
import 'package:manas_suu_app/feature/main/presentation/pages/sub_pages/main_add_user_account_page.dart'
    as _i6;
import 'package:manas_suu_app/feature/notifications/data/models/notifications_model.dart'
    as _i18;
import 'package:manas_suu_app/feature/notifications/presentation/pages/notifications_page.dart'
    as _i10;
import 'package:manas_suu_app/feature/notifications/presentation/pages/sub_pages/notification_detail_page.dart'
    as _i9;
import 'package:manas_suu_app/feature/scanner/presentation/pages/scanner_page.dart'
    as _i11;
import 'package:manas_suu_app/feature/settings/presentation/pages/settings_page.dart'
    as _i12;
import 'package:manas_suu_app/feature/splash/presentation/pages/splash_page.dart'
    as _i13;

/// generated route for
/// [_i1.AccountDetailPage]
class AccountDetailRoute extends _i14.PageRouteInfo<AccountDetailRouteArgs> {
  AccountDetailRoute({
    _i15.Key? key,
    required _i16.AccountDetailData detail,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         AccountDetailRoute.name,
         args: AccountDetailRouteArgs(key: key, detail: detail),
         initialChildren: children,
       );

  static const String name = 'AccountDetailRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountDetailRouteArgs>();
      return _i1.AccountDetailPage(key: args.key, detail: args.detail);
    },
  );
}

class AccountDetailRouteArgs {
  const AccountDetailRouteArgs({this.key, required this.detail});

  final _i15.Key? key;

  final _i16.AccountDetailData detail;

  @override
  String toString() {
    return 'AccountDetailRouteArgs{key: $key, detail: $detail}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccountDetailRouteArgs) return false;
    return key == other.key && detail == other.detail;
  }

  @override
  int get hashCode => key.hashCode ^ detail.hashCode;
}

/// generated route for
/// [_i2.AppPdfviewerPage]
class AppPdfviewerRoute extends _i14.PageRouteInfo<AppPdfviewerRouteArgs> {
  AppPdfviewerRoute({
    _i15.Key? key,
    String? filePath,
    String? base64Pdf,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         AppPdfviewerRoute.name,
         args: AppPdfviewerRouteArgs(
           key: key,
           filePath: filePath,
           base64Pdf: base64Pdf,
         ),
         initialChildren: children,
       );

  static const String name = 'AppPdfviewerRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppPdfviewerRouteArgs>(
        orElse: () => const AppPdfviewerRouteArgs(),
      );
      return _i2.AppPdfviewerPage(
        key: args.key,
        filePath: args.filePath,
        base64Pdf: args.base64Pdf,
      );
    },
  );
}

class AppPdfviewerRouteArgs {
  const AppPdfviewerRouteArgs({this.key, this.filePath, this.base64Pdf});

  final _i15.Key? key;

  final String? filePath;

  final String? base64Pdf;

  @override
  String toString() {
    return 'AppPdfviewerRouteArgs{key: $key, filePath: $filePath, base64Pdf: $base64Pdf}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppPdfviewerRouteArgs) return false;
    return key == other.key &&
        filePath == other.filePath &&
        base64Pdf == other.base64Pdf;
  }

  @override
  int get hashCode => key.hashCode ^ filePath.hashCode ^ base64Pdf.hashCode;
}

/// generated route for
/// [_i3.BottomNavigationPage]
class BottomNavigationRoute extends _i14.PageRouteInfo<void> {
  const BottomNavigationRoute({List<_i14.PageRouteInfo>? children})
    : super(BottomNavigationRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.BottomNavigationPage();
    },
  );
}

/// generated route for
/// [_i4.ContactsPage]
class ContactsRoute extends _i14.PageRouteInfo<void> {
  const ContactsRoute({List<_i14.PageRouteInfo>? children})
    : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.ContactsPage();
    },
  );
}

/// generated route for
/// [_i5.HistoryChargesDetailPage]
class HistoryChargesDetailRoute
    extends _i14.PageRouteInfo<HistoryChargesDetailRouteArgs> {
  HistoryChargesDetailRoute({
    _i15.Key? key,
    required _i17.HistoryModel period,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         HistoryChargesDetailRoute.name,
         args: HistoryChargesDetailRouteArgs(key: key, period: period),
         initialChildren: children,
       );

  static const String name = 'HistoryChargesDetailRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HistoryChargesDetailRouteArgs>();
      return _i5.HistoryChargesDetailPage(key: args.key, period: args.period);
    },
  );
}

class HistoryChargesDetailRouteArgs {
  const HistoryChargesDetailRouteArgs({this.key, required this.period});

  final _i15.Key? key;

  final _i17.HistoryModel period;

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
/// [_i6.MainAddUserAccountPage]
class MainAddUserAccountRoute
    extends _i14.PageRouteInfo<MainAddUserAccountRouteArgs> {
  MainAddUserAccountRoute({
    _i15.Key? key,
    bool isAddedAccount = false,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         MainAddUserAccountRoute.name,
         args: MainAddUserAccountRouteArgs(
           key: key,
           isAddedAccount: isAddedAccount,
         ),
         initialChildren: children,
       );

  static const String name = 'MainAddUserAccountRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainAddUserAccountRouteArgs>(
        orElse: () => const MainAddUserAccountRouteArgs(),
      );
      return _i6.MainAddUserAccountPage(
        key: args.key,
        isAddedAccount: args.isAddedAccount,
      );
    },
  );
}

class MainAddUserAccountRouteArgs {
  const MainAddUserAccountRouteArgs({this.key, this.isAddedAccount = false});

  final _i15.Key? key;

  final bool isAddedAccount;

  @override
  String toString() {
    return 'MainAddUserAccountRouteArgs{key: $key, isAddedAccount: $isAddedAccount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainAddUserAccountRouteArgs) return false;
    return key == other.key && isAddedAccount == other.isAddedAccount;
  }

  @override
  int get hashCode => key.hashCode ^ isAddedAccount.hashCode;
}

/// generated route for
/// [_i7.MainHistoryPage]
class MainHistoryRoute extends _i14.PageRouteInfo<MainHistoryRouteArgs> {
  MainHistoryRoute({
    _i15.Key? key,
    required _i17.HistoryData model,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         MainHistoryRoute.name,
         args: MainHistoryRouteArgs(key: key, model: model),
         initialChildren: children,
       );

  static const String name = 'MainHistoryRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainHistoryRouteArgs>();
      return _i7.MainHistoryPage(key: args.key, model: args.model);
    },
  );
}

class MainHistoryRouteArgs {
  const MainHistoryRouteArgs({this.key, required this.model});

  final _i15.Key? key;

  final _i17.HistoryData model;

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
/// [_i8.MainPage]
class MainRoute extends _i14.PageRouteInfo<void> {
  const MainRoute({List<_i14.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.MainPage();
    },
  );
}

/// generated route for
/// [_i9.NotificationDetailPage]
class NotificationDetailRoute
    extends _i14.PageRouteInfo<NotificationDetailRouteArgs> {
  NotificationDetailRoute({
    _i15.Key? key,
    required _i18.NotificationsModel item,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         NotificationDetailRoute.name,
         args: NotificationDetailRouteArgs(key: key, item: item),
         initialChildren: children,
       );

  static const String name = 'NotificationDetailRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationDetailRouteArgs>();
      return _i9.NotificationDetailPage(key: args.key, item: args.item);
    },
  );
}

class NotificationDetailRouteArgs {
  const NotificationDetailRouteArgs({this.key, required this.item});

  final _i15.Key? key;

  final _i18.NotificationsModel item;

  @override
  String toString() {
    return 'NotificationDetailRouteArgs{key: $key, item: $item}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationDetailRouteArgs) return false;
    return key == other.key && item == other.item;
  }

  @override
  int get hashCode => key.hashCode ^ item.hashCode;
}

/// generated route for
/// [_i10.NotificationsPage]
class NotificationsRoute extends _i14.PageRouteInfo<void> {
  const NotificationsRoute({List<_i14.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.NotificationsPage();
    },
  );
}

/// generated route for
/// [_i11.ScannerPage]
class ScannerRoute extends _i14.PageRouteInfo<void> {
  const ScannerRoute({List<_i14.PageRouteInfo>? children})
    : super(ScannerRoute.name, initialChildren: children);

  static const String name = 'ScannerRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.ScannerPage();
    },
  );
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute({List<_i14.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsPage();
    },
  );
}

/// generated route for
/// [_i13.SplashPage]
class SplashRoute extends _i14.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    _i15.Key? key,
    double progress = 1,
    String version = '1.0.11+11',
    List<_i14.PageRouteInfo>? children,
  }) : super(
         SplashRoute.name,
         args: SplashRouteArgs(key: key, progress: progress, version: version),
         initialChildren: children,
       );

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SplashRouteArgs>(
        orElse: () => const SplashRouteArgs(),
      );
      return _i14.WrappedRoute(
        child: _i13.SplashPage(
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

  final _i15.Key? key;

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
