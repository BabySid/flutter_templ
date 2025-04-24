import 'package:flutter/material.dart';

class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  const AnimatedDecoratedBox({
    super.key,
    required this.decoration,
    required this.child,
    super.curve,
    required super.duration,
  });
  final BoxDecoration decoration;
  final Widget child;

  @override
  AnimatedWidgetBaseState<AnimatedDecoratedBox> createState() =>
      _AnimatedDecoratedBoxState();
}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox> {
  DecorationTween? _decoration;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration!.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration =
        visitor(
              _decoration,
              widget.decoration,
              (value) => DecorationTween(begin: value),
            )
            as DecorationTween;
  }
}
