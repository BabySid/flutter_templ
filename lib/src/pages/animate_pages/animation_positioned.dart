import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class MyAnimatedPositionedPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedPositioned";
  @override
  String get name => _name;

  const MyAnimatedPositionedPage({super.key});

  @override
  State<MyAnimatedPositionedPage> createState() =>
      _MyAnimatedPositionedPageState();
}

class _MyAnimatedPositionedPageState extends State<MyAnimatedPositionedPage> {
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
          Stack(
            children: [
              Container(width: 300, height: 300, color: Colors.yellow),
              AnimatedPositioned(
                curve: Curves.linear,
                right: flag ? 10 : 200,
                top: flag ? 10 : 200,
                duration: const Duration(seconds: 1, milliseconds: 500),
                child: Container(width: 60, height: 60, color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
