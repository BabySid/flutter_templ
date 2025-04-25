import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class CustomPaintAndCanvasPage extends StatelessWidget implements NameProvider {
  static const String _name = "CustomPaintAndCanvas";
  @override
  String get name => _name;

  const CustomPaintAndCanvasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RepaintBoundary(
              // RepaintBoundary避免子节点不必要的重绘(.paint()被调用)
              // 在ElevatedButton.onPressed不断的刷新画布，就导致了CustomPaint 不停的重绘
              // 所以加上RepaintBoundary就形成一个新的画布
              child: CustomPaint(
                size: Size(300, 300), //指定画布大小
                painter: _MyPainter(),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("刷新")),
          ],
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //print('paint');
    var rect = Offset.zero & size;
    // 性能优化建议2
    // 绘制尽可能多的分层；在上面五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，
    // 这样会有一个问题：由于棋盘始终是不变的，用户每次落子时变的只是棋子，但是如果按照下面的代码来实现，
    // 每次绘制棋子时都要重新绘制一次棋盘，这是没必要的。优化的方法就是将棋盘单独抽为一个组件，
    // 并设置其shouldRepaint回调值为false，然后将棋盘组件作为背景。
    // 然后将棋子的绘制放到另一个组件中，这样每次落子时只需要绘制棋子

    //画棋盘
    drawChessboard(canvas, rect);
    //画棋子
    drawPieces(canvas, rect);
  }

  // 性能优化建议1:
  // 在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；假如我们绘制的UI不依赖外部状态，
  // 即外部状态改变不会影响我们的UI外观，那么就应该返回false；如果绘制依赖外部状态，
  // 那么我们就应该在shouldRepaint中判断依赖的状态是否改变，如果已改变则应返回true来重绘，反之则应返回false不需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void drawChessboard(Canvas canvas, Rect rect) {
  //棋盘背景
  var paint =
      Paint()
        ..isAntiAlias = true
        ..style =
            PaintingStyle
                .fill //填充
        ..color = Color(0xFFDCC48C);
  canvas.drawRect(rect, paint);

  //画棋盘网格
  paint
    ..style =
        PaintingStyle
            .stroke //线
    ..color = Colors.black38
    ..strokeWidth = 1.0;

  //画横线
  for (int i = 0; i <= 15; ++i) {
    double dy = rect.top + rect.height / 15 * i;
    canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
  }

  for (int i = 0; i <= 15; ++i) {
    double dx = rect.left + rect.width / 15 * i;
    canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
  }
}

//画棋子
void drawPieces(Canvas canvas, Rect rect) {
  double eWidth = rect.width / 15;
  double eHeight = rect.height / 15;
  //画一个黑子
  var paint =
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.black;
  //画一个黑子
  canvas.drawCircle(
    Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
    min(eWidth / 2, eHeight / 2) - 2,
    paint,
  );
  //画一个白子
  paint.color = Colors.white;
  canvas.drawCircle(
    Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
    min(eWidth / 2, eHeight / 2) - 2,
    paint,
  );
}
