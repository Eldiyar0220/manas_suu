import 'package:auto_route/auto_route.dart';

extension CustomAutoRouter on StackRouter {
  Future<void> pushAndRemoveUntil(PageRouteInfo route) async {
    push(route);
    removeWhere((element) => true);
  }
}
