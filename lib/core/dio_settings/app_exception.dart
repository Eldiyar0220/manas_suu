import 'dart:io';

import 'package:dio/dio.dart';

class AppException implements Exception {
  AppException({this.message});

  final String? message;

  /// Создаёт [AppException] из [SocketException].
  /// Ошибка отсутствия интернета или недоступности хоста.
  factory AppException.fromSocketException(SocketException e) {
    return AppException(
      message: 'Нет подключения к интернету. Проверьте соединение.',
    );
  }

  /// Создаёт [AppException] из [DioException].
  /// Обрабатывает: SocketException, отсутствие интернета, таймауты, response.data['message'].
  factory AppException.fromDioException(DioException e) {
    // SocketException (часто причина connectionError)
    final error = e.error;
    if (error is SocketException) {
      return AppException.fromSocketException(error);
    }
    // Ошибка соединения / нет интернета
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return AppException(
        message: 'Нет подключения к интернету. Проверьте соединение.',
      );
    }

    // Ответ от сервера с ошибкой
    if (e.type == DioExceptionType.badResponse && e.response != null) {
      final data = e.response!.data;
      final message = _extractMessage(data) ??
          _statusCodeMessage(e.response!.statusCode);
      return AppException(message: message);
    }

    // Отмена запроса
    if (e.type == DioExceptionType.cancel) {
      return AppException(message: 'Запрос отменён');
    }

    return AppException(message: e.message ?? 'Произошла ошибка');
  }

  /// Извлекает message из response.data.
  /// Поддерживает: data['message'], data['error']['message'].
  static String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is! Map) return data.toString();

    // data['message'] — может быть String или List
    final message = data['message'];
    if (message != null) {
      if (message is String) return message;
      if (message is List && message.isNotEmpty) return message.first.toString();
    }

    // data['error']['message']
    final error = data['error'];
    if (error is Map) {
      final msg = error['message'];
      if (msg != null && msg is String) return msg;
    }

    // data['msg']
    final msg = data['msg'];
    if (msg != null && msg is String) return msg;

    return null;
  }

  static String _statusCodeMessage(int? code) {
    switch (code) {
      case 400:
        return 'Неверный запрос';
      case 401:
        return 'Требуется авторизация';
      case 403:
        return 'Доступ запрещён';
      case 404:
        return 'Не найдено';
      case 500:
        return 'Ошибка сервера';
      default:
        return 'Произошла ошибка (код $code)';
    }
  }

  @override
  String toString() => 'AppException: ${message ?? "Unknown error"}';
}
