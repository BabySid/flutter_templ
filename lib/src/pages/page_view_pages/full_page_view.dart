import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

// 上滑无限加载
class FullPageViewPage extends StatefulWidget implements NameProvider {
  static const String _name = "FullPageView";
  @override
  String get name => _name;

  const FullPageViewPage({super.key});

  @override
  State<FullPageViewPage> createState() => _FullPageViewPageState();
}

class _FullPageViewPageState extends State<FullPageViewPage> {
  List<Widget> list = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 5; i++) {
      list.add(
        Center(child: Text("第${i + 1}屏", style: const TextStyle(fontSize: 60))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          if (index + 2 == list.length) {
            setState(() {
              for (var i = 0; i < 5; i++) {
                list.add(
                  Center(
                    child: Text(
                      "第${index + 2 + i + 1}屏",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                );
              }
            });
          }
        },
        children: list,
      ),
    );
  }
}
