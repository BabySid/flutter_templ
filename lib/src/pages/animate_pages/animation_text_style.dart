import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class MyAnimatedTextStylePage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedTextStyle";
  @override
  String get name => _name;

  const MyAnimatedTextStylePage({super.key});

  @override
  State<MyAnimatedTextStylePage> createState() =>
      _MyAnimatedTextStylePageState();
}

class _MyAnimatedTextStylePageState extends State<MyAnimatedTextStylePage> {
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
          Container(
            alignment: Alignment.center,
            width: 300,
            height: 300,
            color: Colors.blue,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 1),
              style: TextStyle(fontSize: flag ? 20 : 50, color: Colors.black),
              child: const Text("欲穷千里目，更上一层楼。"),
            ),
          ),
        ],
      ),
    );
  }
}
