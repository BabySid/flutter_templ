import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class GesturePage extends StatefulWidget implements NameProvider {
  static const String _name = "Gesture";
  @override
  String get name => _name;

  const GesturePage({super.key});

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  String _operation = "No Gesture detected!"; //保存事件名

  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移
  DragDownDetails? _downDetails;
  DragUpdateDetails? _upDetails;
  DragEndDetails? _endDetails;
  double _width = 100.0; //通过修改图片宽度来达到缩放效果

  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("GestureDetector"),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.lightBlue,
                width: 400.0,
                height: 200.0,
                child: Text(_operation, style: TextStyle(color: Colors.white)),
              ),
              onTap: () => updateText("Tap"), //点击
              onDoubleTap: () => updateText("DoubleTap"), //双击
              onLongPress: () => updateText("LongPress"), //长按
            ),
            Divider(),
            Text(
              "Drag: _downDetails=${_downDetails?.localPosition} _upDetails=${_upDetails?.delta} _endDetails=${_endDetails?.velocity}",
            ),
            Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: _top,
                    left: _left,
                    child: GestureDetector(
                      child: CircleAvatar(child: const Text("A")),
                      //手指按下时会触发此回调
                      onPanDown: (DragDownDetails e) {
                        //打印手指按下的位置(相对于屏幕)
                        setState(() {
                          _downDetails = e;
                        });

                        //print("用户手指按下：${e.globalPosition}");
                      },
                      //手指滑动时会触发此回调
                      onPanUpdate: (DragUpdateDetails e) {
                        //用户手指滑动时，更新偏移，重新构建
                        setState(() {
                          _upDetails = e;
                          _left += e.delta.dx;
                          _top += e.delta.dy;
                        });
                      },
                      onPanEnd: (DragEndDetails e) {
                        //打印滑动结束时在x、y轴上的速度
                        setState(() {
                          _endDetails = e;
                        });
                        //print(e.velocity);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Text("Scale _width=$_width"),
            Center(
              child: GestureDetector(
                //指定宽度，高度自适应
                child: Image.asset("assets/images/avatar.jpg", width: _width),
                onScaleUpdate: (ScaleUpdateDetails details) {
                  setState(() {
                    //缩放倍数在0.8到10倍之间
                    _width = 100 * details.scale.clamp(.8, 10.0);
                  });
                },
              ),
            ),
            Divider(),
            const Text("GestureRecognizer"),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "你好世界"),
                  TextSpan(
                    text: "点我变色",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: _toggle ? Colors.blue : Colors.red,
                    ),
                    recognizer:
                        _tapGestureRecognizer
                          ..onTap = () {
                            setState(() {
                              _toggle = !_toggle;
                            });
                          },
                  ),
                  TextSpan(text: "你好世界"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
