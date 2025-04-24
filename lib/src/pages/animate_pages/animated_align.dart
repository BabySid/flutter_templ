import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class MyAnimatedAlignPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedAlign";
  @override
  String get name => _name;

  const MyAnimatedAlignPage({super.key});

  @override
  State<MyAnimatedAlignPage> createState() => _MyAnimatedAlignPageState();
}

class _MyAnimatedAlignPageState extends State<MyAnimatedAlignPage> {
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
          AnimatedAlign(
            alignment: flag ? Alignment.topLeft : Alignment.topRight,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: const Text("唧唧复唧唧，木兰当户织"),
          ),
        ],
      ),
    );
  }
}
