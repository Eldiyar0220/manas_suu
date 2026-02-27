import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/extensions/context_extensions.dart';

// ignore: avoid_classes_with_only_static_members
final class MegaScaler {
  static TextScaler freezed(
    BuildContext context, {
    double maxTextScaleFactor = 2,
  }) {
    final val = (context.width / 1400) * maxTextScaleFactor;
    return TextScaler.linear(max(1, min(val, maxTextScaleFactor)));
  }

  static double adaptive(
    BuildContext context, {
    required double originalFontSize,
    double maxScaleFactor = 2,
  }) {
    final textScaler = MediaQuery.textScalerOf(context);
    var scaleFactor = textScaler.scale(1);
    if (scaleFactor > maxScaleFactor) {
      scaleFactor = maxScaleFactor;
    }
    return originalFontSize / scaleFactor;
  }
}

class CustomText extends StatelessWidget {
  const CustomText(
    this.data, {
    this.style,
    this.maxLines,
    this.textAlign,
    this.overflow,
    super.key,
  }) : isSelectableText = false,
       isLocale = false;

  const CustomText.tr(
    this.data, {
    this.style,
    this.maxLines,
    this.textAlign,
    this.overflow,
    super.key,
  }) : isSelectableText = false,
       isLocale = true;

  const CustomText.selectable(
    this.data, {
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
  }) : overflow = null,
       isSelectableText = true,
       isLocale = false;

  final String data;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool isSelectableText;
  final bool isLocale;

  @override
  Widget build(BuildContext context) {
    final getWidget = Text(
      data,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: MegaScaler.freezed(context),
    );

    if (isSelectableText) {
      return SelectableText(
        data,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        textScaler: MegaScaler.freezed(context),
      );
    } else if (isLocale) {
      return getWidget.tr();
    } else {
      return getWidget;
    }
  }
}
