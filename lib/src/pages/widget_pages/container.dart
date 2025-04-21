import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetContainerPage extends StatelessWidget implements NameProvider {
  static const String _name = "Container";
  @override
  String get name => _name;

  const WidgetContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 40,
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              // padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "按钮",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                // 修饰Container
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20), // 圆角
              ),
              child: const Text("Base Container"),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.yellow,
                gradient: const RadialGradient(
                  //背景径向渐变
                  colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.orange,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 10,
                  ),
                ],
                border: Border.all(color: Colors.black, width: 2),
              ),
              transform: Matrix4.rotationZ(.2),
              child: const Text("Container with BoxDecoration"),
            ),
            Divider(),
            Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.all(20), // 容器外边距
              color: Colors.orange,
              child: const Text("Container with margin"),
            ),
            Divider(),
            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(20), // 容器内边距
              color: Colors.orange,
              child: const Text("Container with padding"),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
