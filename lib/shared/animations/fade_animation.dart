import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, height }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({
    Key key,
    this.delay,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps>()
      ..add(
        AniProps.opacity,
        0.0.tweenTo(1.0),
        500.milliseconds,
      )
      ..add(
        AniProps.height,
        (-30.0).tweenTo(0.0),
        500.milliseconds,
        Curves.easeOut,
      );

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      tween: _tween,
      duration: _tween.duration,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
          offset: Offset(0.0, value.get(AniProps.height)),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
