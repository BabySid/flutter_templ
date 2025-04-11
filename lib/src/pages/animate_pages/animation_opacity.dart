import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class MyAnimatedOpacityPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedOpacity";
  @override
  String get name => _name;

  const MyAnimatedOpacityPage({super.key});

  @override
  State<MyAnimatedOpacityPage> createState() => _MyAnimatedOpacityPageState();
}

class _MyAnimatedOpacityPageState extends State<MyAnimatedOpacityPage> {
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
          AnimatedOpacity(
            opacity: flag ? 1 : 0.1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: const Text("百川东到海，何日复西归。"),
          ),
        ],
      ),
    );
  }
}
