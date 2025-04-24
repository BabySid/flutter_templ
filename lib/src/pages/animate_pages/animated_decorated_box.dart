import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/animated_decorated_box.dart';

class AnimatedDecoratedBoxPage extends StatefulWidget implements NameProvider {
  static const String _name = "AnimatedDecoratedBox";
  @override
  String get name => _name;

  const AnimatedDecoratedBoxPage({super.key});

  @override
  State<AnimatedDecoratedBoxPage> createState() =>
      _AnimatedDecoratedBoxPageState();
}

class _AnimatedDecoratedBoxPageState extends State<AnimatedDecoratedBoxPage> {
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: AnimatedDecoratedBox(
              duration: const Duration(seconds: 1),
              decoration: BoxDecoration(color: _decorationColor),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _decorationColor =
                        (_decorationColor == Colors.red)
                            ? Colors.blue
                            : Colors.red;
                  });
                },
                child: const Text(
                  "AnimatedDecoratedBox",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
