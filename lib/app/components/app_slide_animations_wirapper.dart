import 'package:flutter/material.dart';

class AppSlideAnimationWrapper extends StatelessWidget {
  const AppSlideAnimationWrapper(this.anim, this.child, {super.key});
  final Animation<double> anim;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (context, _) {
        return Opacity(
          opacity: anim.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - anim.value)),
            child: child,
          ),
        );
      },
    );
  }
}
