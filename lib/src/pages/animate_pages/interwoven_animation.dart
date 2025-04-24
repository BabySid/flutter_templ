import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class InterWovenAnimationPage extends StatefulWidget implements NameProvider {
  static const String _name = "InterWovenAnimation";
  @override
  String get name => _name;

  const InterWovenAnimationPage({super.key});

  @override
  State<InterWovenAnimationPage> createState() =>
      _InterWovenAnimationPageState();
}

class _InterWovenAnimationPageState extends State<InterWovenAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      //捕获异常。可能发生在组件销毁时，计时器会被取消。
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _playAnimation(),
              child: Text("start animation"),
            ),
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((255.0 * 0.1).round()),
                border: Border.all(
                  color: Colors.black.withAlpha((255.0 * 0.5).round()),
                ),
              ),
              //调用我们定义的交错动画Widget
              child: _StaggerAnimation(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    super.dispose();
  }
}

class _StaggerAnimation extends StatelessWidget {
  _StaggerAnimation({super.key, required this.controller}) {
    //高度动画
    height = Tween<double>(begin: .0, end: 300.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: .0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.6,
          1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(color: color.value, width: 50.0, height: height.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(builder: _buildAnimation, animation: controller);
  }
}
