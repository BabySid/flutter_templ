import 'dart:math';
import 'package:flutter/material.dart';

/// A circular progress indicator with gradient effect.
class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    super.key,
    required this.radius,
    this.stokeWidth = 2.0,
    this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.fullColor,
    this.value,
  });

  /// The width of the line used to draw the circle.
  final double stokeWidth;

  /// The radius of the [GradientCircularProgressIndicator]
  final double radius;

  /// The kind of finish to place on the end of arc drawn .
  /// if `true`, [StrokeCap.round] will be set to `Paint.strokeCap`.
  final bool strokeCapRound;

  /// The value of this progress indicator with 0.0 corresponding
  /// to no progress having been made and 1.0 corresponding to all the progress
  /// having been made.
  final double? value;

  /// The progress color when value is 1.
  final Color? fullColor;

  /// The progress indicator's background color. The current theme's
  /// `Color(0xFFEEEEEE)` by default.
  final Color backgroundColor;

  /// The total angle of the progress. Defaults to 2*pi (entire circle)
  final double totalAngle;

  /// The colors the gradient should obtain at each of the stops.
  ///
  /// If [stops] is non-null, this list must have the same length as [stops].
  ///
  /// This list must have at least two colors in it (otherwise, it's not a
  /// gradient!).
  final List<Color>? colors;

  /// A list of values from 0.0 to 1.0 that denote fractions along the gradient.
  ///
  /// If non-null, this list must have the same length as [colors].
  ///
  /// If the first value is not 0.0, then a stop with position 0.0 and a color
  /// equal to the first color in [colors] is implied.
  ///
  /// If the last value is not 1.0, then a stop with position 1.0 and a color
  /// equal to the last color in [colors] is implied.
  ///
  /// The values in the [stops] list must be in ascending order. If a value in
  /// the [stops] list is less than an earlier value in the list, then its value
  /// is assumed to equal the previous value.
  ///
  /// If stops is null, then a set of uniformly distributed stops is implied,
  /// with the first stop at 0.0 and the last stop at 1.0.
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // 下面调整的角度的计算公式是通过数学几何知识得出
    if (strokeCapRound && totalAngle != 2 * pi) {
      offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
    var myColors = colors;
    if (myColors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      myColors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          stokeWidth: stokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          fullColor: fullColor,
          total: totalAngle,
          stops: stops,
          radius: radius,
          colors: myColors,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  const _GradientCircularProgressPainter({
    this.stokeWidth = 10.0,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.radius,
    this.total = 2 * pi,
    required this.colors,
    this.stops,
    this.value,
    this.fullColor,
  });

  final double stokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double? radius;
  final List<double>? stops;
  final Color? fullColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius!);
    }
    double offset = stokeWidth / 2.0;
    double myValue = (value ?? .0);
    myValue = myValue.clamp(.0, 1.0) * total;
    double start = .0;

    if (strokeCapRound) {
      start = asin(stokeWidth / (size.width - stokeWidth));
    }

    Rect rect =
        Offset(offset, offset) &
        Size(size.width - stokeWidth, size.height - stokeWidth);

    var paint =
        Paint()
          ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true
          ..strokeWidth = stokeWidth;

    // draw background arc
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, start, total, false, paint);
    }

    if (value == 1 && fullColor != null) {
      paint.color = fullColor!;
      canvas.drawArc(rect, start, myValue, false, paint);
    } else if (myValue > 0) {
      // draw foreground arc and apply gradient
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: myValue,
        colors: colors,
        stops: stops,
      ).createShader(rect);
      canvas.drawArc(rect, start, myValue, false, paint);
    }
  }

  @override
  bool shouldRepaint(_GradientCircularProgressPainter old) {
    return old.stokeWidth != stokeWidth ||
        old.strokeCapRound != strokeCapRound ||
        old.backgroundColor != backgroundColor ||
        old.radius != radius ||
        old.value != value ||
        old.fullColor != fullColor ||
        old.colors.toString() != colors.toString() ||
        old.stops.toString() != stops.toString();
  }
}
