import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class MyAnimatedPaddingPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedPadding";
  @override
  String get name => _name;

  const MyAnimatedPaddingPage({super.key});

  @override
  State<MyAnimatedPaddingPage> createState() => _MyAnimatedPaddingPageState();
}

class _MyAnimatedPaddingPageState extends State<MyAnimatedPaddingPage> {
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
          AnimatedPadding(
            curve: Curves.bounceInOut,
            padding: EdgeInsets.fromLTRB(10, flag ? 10 : 300, 0, 0),
            duration: const Duration(seconds: 2),
            child: const Text("锄禾日当午，汗滴禾下土。"),
          ),
        ],
      ),
    );
  }
}
