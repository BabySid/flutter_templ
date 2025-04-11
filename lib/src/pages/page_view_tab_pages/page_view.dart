import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class BasicPageViewPage extends StatelessWidget implements NameProvider {
  static const String _name = "BasicPageView";
  @override
  String get name => _name;

  const BasicPageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 或者简单的直接采用PageView(children: [...],)
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical, //垂直
        itemCount: 10,
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              "第${index + 1}屏",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        },
      ),
    );
  }
}
