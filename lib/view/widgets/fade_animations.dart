import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

enum AnimationType { opacity, translateY }

class FadeAnimation extends NoteStatelessWidget {
  final double delay;
  final Widget child;

   FadeAnimation({required this.delay, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(
        AnimationType.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 500),
      )
      ..add(
        AnimationType.translateY,
        Tween(begin: -30.0, end: 1.0),
        const Duration(milliseconds: 500),
      );

    return PlayAnimation<MultiTweenValues<AnimationType>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationType.opacity),
        child: Transform.translate(
            offset: Offset(0, -value.get(AnimationType.translateY)),
            child: child),
      ),
    );
  }
}
