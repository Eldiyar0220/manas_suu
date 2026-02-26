import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manas_suu_app/app/constants/navigator_key.dart';
import 'package:manas_suu_app/core/dio_settings/app_exception.dart';

/// Показывает Flushbar с ошибкой.
/// Контекст берётся из [navigatorKey.currentContext].
///
/// [message] — текст ошибки.
/// [title] — заголовок (опционально).
Future<void> showErrorFlushbar(
  String message, {
  String? title,
  Duration duration = const Duration(seconds: 4),
}) async {
  final context = navigatorKey.currentContext;
  if (context == null || !context.mounted) return;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final backgroundColor = isDark ? const Color(0xFF2D2D2D) : const Color(0xFFFFEBEE);
  final textColor = isDark ? Colors.white : const Color(0xFFB71C1C);
  final iconColor = isDark ? Colors.redAccent : Colors.red;

  return Flushbar(
    title: title,
    message: message,
    titleColor: textColor,
    messageColor: textColor.withValues(alpha: isDark ? 0.9 : 0.8),
    icon: Icon(Icons.error_outline, color: iconColor, size: 28),
    leftBarIndicatorColor: iconColor,
    backgroundColor: backgroundColor,
    borderRadius: BorderRadius.circular(12),
    margin: const EdgeInsets.all(12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    duration: duration,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  ).show(context);
}

/// Показывает Flushbar из [AppException].
/// Контекст берётся из [navigatorKey.currentContext].
Future<void> showAppExceptionFlushbar(AppException exception) {
  return showErrorFlushbar(exception.message ?? 'Произошла ошибка');
}

/// Показывает Flushbar из [DioException].
/// Контекст берётся из [navigatorKey.currentContext].
/// Извлекает [AppException] из e.error или создаёт из DioException.
Future<void> showDioExceptionFlushbar(DioException e) {
  final appException = e.error is AppException
      ? e.error as AppException
      : AppException.fromDioException(e);
  return showAppExceptionFlushbar(appException);
}

/// Показывает Flushbar для любой ошибки.
/// Контекст берётся из [navigatorKey.currentContext].
/// Обрабатывает [AppException], [DioException], [Exception].
Future<void> showErrorFlushbarFrom(Object error) async {
  if (error is AppException) {
    return showAppExceptionFlushbar(error);
  }
  if (error is DioException) {
    return showDioExceptionFlushbar(error);
  }
  return showErrorFlushbar(
    error is Exception ? error.toString() : 'Произошла ошибка',
  );
}
