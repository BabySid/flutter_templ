import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/gradient_button.dart';
import 'package:flutter_teml/src/widgets/turn_box.dart';

class CustomWidgetPage extends StatefulWidget implements NameProvider {
  static const String _name = "CustomWidget";
  @override
  String get name => _name;

  const CustomWidgetPage({super.key});

  @override
  State<CustomWidgetPage> createState() => _CustomWidgetPageState();
}

class _CustomWidgetPageState extends State<CustomWidgetPage> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Divider(),
          TurnBox(
            turns: _turns,
            speed: 500,
            child: const Icon(Icons.refresh, size: 50),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: const Icon(Icons.refresh, size: 150.0),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GradientButton(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                colors: [Colors.lightBlue.shade300, Colors.black],
                splashColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _turns += 0.25;
                  });
                },
                child: const Text("顺时针旋转"),
              ),
              ElevatedGradientButton(
                colors: [Colors.red, Colors.orange],
                onPressed: () {
                  setState(() {
                    _turns -= 0.25;
                  });
                },
                padding: const EdgeInsets.all(10),
                splashColor: Colors.brown,
                borderRadius: BorderRadius.circular(20),
                textColor: Colors.white,
                child: const Text("逆时针旋转"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
