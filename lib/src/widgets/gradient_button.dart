import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.colors,
    required this.onPressed,
    required this.child,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
  });

  // 渐变色数组
  final List<Color>? colors;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> myColors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];
    final radius = borderRadius;
    bool disabled = onPressed == null;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: disabled ? null : LinearGradient(colors: myColors),
        color: disabled ? disabledColor ?? theme.disabledColor : null,
        borderRadius: radius,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: radius,
        clipBehavior: Clip.hardEdge,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          child: InkWell(
            splashColor: splashColor ?? myColors.last,
            highlightColor: Colors.transparent,
            onHighlightChanged: onHighlightChanged,
            onTap: onPressed,
            child: Padding(
              padding: padding ?? theme.buttonTheme.padding,
              child: DefaultTextStyle(
                style: const TextStyle(fontWeight: FontWeight.bold),
                child: Center(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: DefaultTextStyle(
                    style: theme.textTheme.labelLarge!.copyWith(
                      color:
                          disabled
                              ? disabledTextColor ?? Colors.black38
                              : textColor ?? Colors.white,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ElevatedGradientButton extends StatefulWidget {
  const ElevatedGradientButton({
    super.key,
    this.colors,
    this.onPressed,
    this.padding,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.textColor,
    this.splashColor,
    this.disabledColor,
    this.disabledTextColor,
    this.onHighlightChanged,
    this.shadowColor,
    required this.child,
  });

  // 渐变色数组
  final List<Color>? colors;
  final Color? textColor;
  final Color? splashColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;
  final ValueChanged<bool>? onHighlightChanged;

  @override
  State<ElevatedGradientButton> createState() => _ElevatedGradientButtonState();
}

class _ElevatedGradientButtonState extends State<ElevatedGradientButton> {
  bool _tapDown = false;

  @override
  Widget build(BuildContext context) {
    bool disabled = widget.onPressed == null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow:
            disabled
                ? null
                : [
                  _tapDown
                      ? BoxShadow(
                        offset: const Offset(2, 6),
                        spreadRadius: -2,
                        blurRadius: 9,
                        color: widget.shadowColor ?? Colors.black54,
                      )
                      : BoxShadow(
                        offset: const Offset(0, 2),
                        spreadRadius: -2,
                        blurRadius: 3,
                        color: widget.shadowColor ?? Colors.black87,
                      ),
                ],
      ),
      child: GradientButton(
        colors: widget.colors,
        onPressed: widget.onPressed,
        padding: widget.padding,
        borderRadius: widget.borderRadius,
        textColor: widget.textColor,
        splashColor: widget.splashColor,
        disabledColor: widget.disabledColor,
        disabledTextColor: widget.disabledTextColor,
        child: widget.child,
        onHighlightChanged: (v) {
          setState(() {
            _tapDown = v;
          });
          if (widget.onHighlightChanged != null) {
            widget.onHighlightChanged!(v);
          }
        },
      ),
    );
  }
}
