import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetStackAlignPosPage extends StatelessWidget implements NameProvider {
  static const String _name = "Stack&Align&Pos";
  @override
  String get name => _name;

  const WidgetStackAlignPosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(height: 200, width: 200, color: Colors.blue.shade50),
                Container(height: 100, width: 100, color: Colors.green),
                const Text("Stack.centerLeft"),
              ],
            ),
            Divider(),
            Container(
              height: 200.0,
              width: 200.0,
              color: Colors.blue.shade50,
              child: const Align(
                alignment: Alignment.topRight,
                child: FlutterLogo(size: 60),
              ),
            ),
            Divider(),
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.red),
              ),
              child: const Align(child: Text("Align without *Factor")),
            ),
            Divider(),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: const Text("Stack&Align"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: const Text("Stack&Align"),
                  ),
                  const Text("Stack.centerRight"),
                ],
              ),
            ),
            Divider(),
            Container(
              width: 300,
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Positioned(left: 10, child: const Text("Positioned.left=10")),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: const Text("Positioned.right=10,bottom=10"),
                  ),
                  const Text("Stack.topRight"),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              width: 200,
              child: AspectRatio(
                aspectRatio: 3 / 1,
                child: Container(
                  alignment: Alignment.center,
                  width: 100,
                  color: Colors.blue,
                  child: const Text("AspectRatio: 3/1"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
