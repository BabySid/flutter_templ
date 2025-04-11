import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class MyAnimatedContainerPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedContainer";
  @override
  String get name => _name;

  const MyAnimatedContainerPage({super.key});

  @override
  State<MyAnimatedContainerPage> createState() =>
      _MyAnimatedContainerPageState();
}

class _MyAnimatedContainerPageState extends State<MyAnimatedContainerPage> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            child: AnimatedContainer(
              duration: const Duration(seconds: 1, milliseconds: 100),
              width: 200,
              height: 200,
              transform:
                  flag
                      ? Matrix4.translationValues(0, 0, 0)
                      : Matrix4.translationValues(-100, 0, 0),
              color: Colors.yellow,
              child: const Text("Hello World"),
            ),
          ),
          Divider(),
          Stack(
            children: [
              Text("一段文本内容：会当凌绝顶，一览众山小。"),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1, milliseconds: 100),
                  width: 300,
                  height: double.infinity,
                  transform:
                      flag
                          ? Matrix4.translationValues(0, 0, 0)
                          : Matrix4.translationValues(-300, 0, 0),
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
