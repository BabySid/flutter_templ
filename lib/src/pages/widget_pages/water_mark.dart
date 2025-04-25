import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/watermark.dart';

class WaterMarkPage extends StatefulWidget implements NameProvider {
  static const String _name = "WaterMark";
  @override
  String get name => _name;

  const WaterMarkPage({super.key});

  @override
  State<WaterMarkPage> createState() => _WaterMarkPageState();
}

class _WaterMarkPageState extends State<WaterMarkPage> {
  int index = 0;
  final int max = 3;

  List<Widget> pages = [
    IgnorePointer(
      child: WaterMark(
        painter: TextWaterMarkPainter(
          text: '你好, Flutter!',
          padding: const EdgeInsets.all(18),
          textStyle: const TextStyle(color: Colors.black38),
          rotate: -10,
        ),
      ),
    ),
    IgnorePointer(
      child: WaterMark(
        painter: StaggerTextWaterMarkPainter(
          text: '这是第一个文本',
          text2: 'This is the second text',
          padding1: const EdgeInsets.all(10),
          padding2: const EdgeInsets.only(
            left: 100,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          rotate: -10,
        ),
      ),
    ),
    IgnorePointer(
      child: TranslateWithExpandedPaintingArea(
        offset: const Offset(-30, 0),
        clipBehavior: Clip.hardEdge,
        child: WaterMark(
          painter: TextWaterMarkPainter(
            text: '水印Secret',
            textStyle: const TextStyle(fontSize: 14, color: Colors.black38),
            rotate: -20,
          ),
        ),
      ),
    ),
  ];

  Widget wPage() {
    return Center(
      child: ElevatedButton(
        child: const Text('按钮'),
        onPressed: () {
          setState(() {
            index = (index + 1) % max;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [wPage(), pages[index]]));
  }
}
