import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class _AnimatedImage extends AnimatedWidget {
  const _AnimatedImage({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        "assets/images/img.jpg",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class AnimatedWidgetPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedWidget";
  @override
  String get name => _name;

  const AnimatedWidgetPage({super.key});

  @override
  State<AnimatedWidgetPage> createState() => _AnimatedWidgetPageState();
}

class _AnimatedWidgetPageState extends State<AnimatedWidgetPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    //图片宽高从0变到300
    animation = Tween(begin: 10.0, end: 100.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _AnimatedImage(animation: animation),
            Divider(),
            // 用AnimatedWidget 可以从动画中分离出 widget，
            // 而动画的渲染过程（即设置宽高）仍然在AnimatedWidget 中，
            // 假设如果再添加一个 widget 透明度变化的动画，
            // 那么我们需要再实现一个AnimatedWidget，这样不是很优雅，
            // 如果我们能把渲染过程也抽象出来，那就会好很多，
            // 而AnimatedBuilder正是将渲染逻辑分离出来, 上面_AnimatedImage的 build 方法中的代码可以改为
            AnimatedBuilder(
              animation: animation,
              child: Image.asset("assets/images/img.jpg"),
              builder: (BuildContext ctx, child) {
                return Center(
                  child: SizedBox(
                    height: animation.value,
                    width: animation.value,
                    child: child,
                  ),
                );
              },
            ),
            Divider(),
            _GrowTransition(
              animation: animation,
              child: Image.asset("assets/images/img.jpg"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class _GrowTransition extends StatelessWidget {
  const _GrowTransition({super.key, required this.animation, this.child});

  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
