import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/theme/app_theme.dart';

extension CustomAutoRouter on StackRouter {
  Future<void> pushAndRemoveUntil(PageRouteInfo route) async {
    push(route);
    removeWhere((element) => true);
  }
}

extension ContextExtension on BuildContext {
  MyColors get theme => Theme.of(this).extension<MyColors>()!;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  MediaQueryData get mQuery => MediaQuery.of(this);
  FocusNode get focusScope => FocusScope.of(this);
}
