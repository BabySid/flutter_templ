import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/after_layout.dart';

class WidgetLayoutPage extends StatefulWidget implements NameProvider {
  static const String _name = "LayoutBuilder&AfterLayout";
  @override
  String get name => _name;

  const WidgetLayoutPage({super.key});

  @override
  State<WidgetLayoutPage> createState() => _WidgetLayoutPageState();
}

class _WidgetLayoutPageState extends State<WidgetLayoutPage> {
  String _text = '我❤️世界';
  Size _size = Size.zero;
  String? _text1Size;
  String? _text2Size;
  String? _text3Size;

  @override
  Widget build(BuildContext context) {
    var children = List.filled(6, Text("我❤️世界"));
    // Column在本示例中在水平方向的最大宽度为屏幕的宽度

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 限制宽度为190，小于 200
            SizedBox(width: 190, child: _ResponsiveColumn(children: children)),
            Divider(),
            _ResponsiveColumn(children: children),
            Divider(),
            Container(
              width: 300,
              color: Colors.teal,
              child: FittedBox(
                fit: BoxFit.none,
                child: wRow("FittedBox.none:我❤️世界"),
              ),
            ),
            Divider(),
            Container(
              width: 300,
              color: Colors.teal,
              child: FittedBox(
                fit: BoxFit.contain,
                child: wRow("FittedBox.contain:我❤️世界"),
              ),
            ),
            Divider(),
            Container(
              width: 500,
              color: Colors.teal,
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return FittedBox(
                    child: ConstrainedBox(
                      constraints: constraints.copyWith(
                        //minWidth: constraints.maxWidth,
                        //maxWidth: double.infinity,
                        maxWidth: constraints.maxWidth,
                      ),
                      child: wRow("Fit.ConBox"),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text('Text1的大小为: $_text1Size'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    child: Text(
                      'Text1: 点我获取我的大小',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap:
                        () => setState(() {
                          _text1Size = "${context.size}";
                        }),
                  );
                },
              ),
            ),
            Text('Text2的大小为: $_text2Size'),
            AfterLayout(
              callback: (RenderAfterLayout ral) {
                setState(() {
                  _text2Size = "${ral.size}, ${ral.offset}";
                });
              },
              child: Text('Text2: 我❤️世界'),
            ),
            Builder(
              builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AfterLayout(
                      callback: (RenderAfterLayout ral) {
                        Offset offset = ral.localToGlobal(
                          Offset.zero,
                          ancestor: context.findRenderObject(), // 找到父节点
                        );

                        setState(() {
                          _text3Size = "${offset & ral.size}";
                        });
                      },
                      child: Text('A'),
                    ),
                    VerticalDivider(),
                    Text('\'A\'在Container中的空间范围是: $_text3Size'),
                  ],
                );
              },
            ),
            Divider(),
            AfterLayout(
              child: Text(_text),
              callback: (RenderAfterLayout value) {
                setState(() {
                  //更新尺寸信息
                  _size = value.size;
                });
              },
            ),
            //显示上面 Text 的尺寸
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Text size: $_size ',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _text += '我❤️世界';
                });
              },
              child: Text('追加字符串'),
            ),
          ],
        ),
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
                  children: [children[i], VerticalDivider(), children[i + 1]],
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

Widget wRow(String text) {
  Widget child = Text(text);
  child = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [child, child, child, child, child],
  );
  return child;
}
