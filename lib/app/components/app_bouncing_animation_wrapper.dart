import 'package:flutter/material.dart';

class AppBouncingAnimationWrapper extends StatelessWidget {
  const AppBouncingAnimationWrapper(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value.clamp(0, 1), child: child),
        );
      },
    );
  }
}
