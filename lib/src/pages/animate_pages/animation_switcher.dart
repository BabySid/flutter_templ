import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/slide_transition.dart';

class MyAnimatedSwitcherPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedSwitcher";
  @override
  String get name => _name;

  const MyAnimatedSwitcherPage({super.key});

  @override
  State<MyAnimatedSwitcherPage> createState() => _MyAnimatedSwitcherPageState();
}

class _MyAnimatedSwitcherPageState extends State<MyAnimatedSwitcherPage> {
  bool flag = true;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  flag = !flag;
                });
              },
              child: const Text("点击切换"),
            ),
            Divider(),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 300,
                height: 220,
                color: Colors.yellow,
                // AnimatedCrossFade 和 AnimatedSwitcher 类似，只不过是针对两个子元素
                child: AnimatedSwitcher(
                  //当子元素改变的时候会触发动画
                  transitionBuilder: ((child, animation) {
                    // FadeTransition(淡入淡出)
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  }),
                  duration: const Duration(seconds: 1),
                  child: Text(
                    key: UniqueKey(), // 去除后，则无切换动画的效果，虽然也可以切换
                    flag ? "Hello World" : "你好，世界",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 220,
              color: Colors.yellow,
              child: AnimatedSwitcher(
                transitionBuilder: ((child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                }),
                duration: const Duration(seconds: 1),
                child:
                    flag
                        ? const CircularProgressIndicator()
                        : Image.asset(
                          "assets/images/avatar.jpg",
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text("加一"),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransitionX(
                  direction: AxisDirection.left, //上入下出
                  position: animation,
                  child: child,
                );
              },
              child: Text("$counter", key: ValueKey<int>(counter)),
            ),
          ],
        ),
      ),
    );
  }
}
