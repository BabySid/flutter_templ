import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetRowColumnFlexPage extends StatelessWidget implements NameProvider {
  static const String _name = "Constraints&Row&Column&Flex";
  @override
  String get name => _name;

  const WidgetRowColumnFlexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
                minHeight: 50.0, //最小高度为50像素
              ),
              child: SizedBox(
                height: 5.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            const Text("ConstrainedBox。约束最小高度为50px"),
            Divider(),
            SizedBox(
              width: 50,
              height: 50,
              child: SizedBox(
                height: 5.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                ),
              ),
            ),
            const Text("SizedBox。约束固定的宽高50px"),
            Divider(),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, maxHeight: 90.0), //父
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30.0,
                  maxHeight: 30.0,
                ), //子
                child: Container(color: Colors.blue, width: 100, height: 100),
              ),
            ),
            const Text("父子多重限制。min取父子最大值, max取父子最小值"),
            Divider(),
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 60.0,
                  minHeight: 60.0,
                ), //父
                child: UnconstrainedBox(
                  //“去除”父级限制
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 30.0,
                      minHeight: 30.0,
                    ), //子
                    child: Container(color: Colors.blue, width: 10, height: 10),
                  ),
                ),
              ),
            ),

            const Text("UnconstrainedBox"),
            Divider(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Padding"),
              ),
            ),
            Divider(),
            Container(
              height: 100,
              width: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                color: Colors.black12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Row0"), Text("Row1"), Text("Row2")],
              ),
            ),
            Divider(),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                color: Colors.black12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Column0"), Text("Column1"), Text("Colum2")],
              ),
            ),
            Divider(),
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                color: Colors.black12,
              ),
              child: Container(
                height: double.maxFinite, // 充满父组件的宽度和高度
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                  color: Colors.purple,
                ),
                child: Text("充满父组件"),
              ),
            ),
            Divider(),
            Flex(
              direction: Axis.horizontal, // 可以使用Row替换
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Text("Flex&Expanded:2", textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    child: Text("Flex&Expanded:1", textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: Text("Flex&Spacer:3", textAlign: TextAlign.center),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 100,
              child: Flex(
                direction: Axis.vertical, // 可以使用Column替换
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: Text(
                        "Flex&Expanded:2",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      child: Text(
                        "Flex&Expanded:1",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              children: [
                Container(
                  width: 300,
                  height: 100,
                  color: Colors.lightBlue,
                  child: const Text("Top"),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.lightGreen,
                              width: 1,
                            ),
                          ),
                          child: const Text("Left"),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 100,
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.redAccent,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text("RightTop"),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueGrey,
                                        width: 1,
                                      ),
                                    ),
                                    child: const Text("RightDown"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
