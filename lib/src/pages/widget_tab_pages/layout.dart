import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetLayoutPage extends StatefulWidget implements NameProvider {
  static const String _name = "LayoutBuilder&AfterLayout";
  @override
  String get name => _name;

  const WidgetLayoutPage({super.key});

  @override
  State<WidgetLayoutPage> createState() => _WidgetLayoutPageState();
}

class _WidgetLayoutPageState extends State<WidgetLayoutPage> {
  @override
  Widget build(BuildContext context) {
    var children = List.filled(6, Text("A"));
    // Column在本示例中在水平方向的最大宽度为屏幕的宽度

    return Scaffold(
      body: Column(
        children: [
          // 限制宽度为190，小于 200
          SizedBox(width: 190, child: _ResponsiveColumn(children: children)),
          Divider(),
          _ResponsiveColumn(children: children),
        ],
      ),
    );
  }
}

class _ResponsiveColumn extends StatelessWidget {
  const _ResponsiveColumn({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // 通过 LayoutBuilder 拿到父组件传递的约束，然后判断 maxWidth 是否小于200
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          // 最大宽度小于200，显示单列
          return Column(mainAxisSize: MainAxisSize.min, children: children);
        } else {
          // 大于200，显示双列
          var tmpChildren = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              tmpChildren.add(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [children[i], children[i + 1]],
                ),
              );
            } else {
              tmpChildren.add(children[i]);
            }
          }
          return Column(mainAxisSize: MainAxisSize.min, children: tmpChildren);
        }
      },
    );
  }
}
