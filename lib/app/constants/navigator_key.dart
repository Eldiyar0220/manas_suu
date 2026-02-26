import 'package:flutter/material.dart';

/// Глобальный ключ навигатора для доступа к [BuildContext] вне дерева виджетов.
/// Используется, например, в [showErrorFlushbarFrom] для показа уведомлений об ошибках.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
