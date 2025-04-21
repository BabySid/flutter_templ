import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class ValueListenableBuilderPage extends StatefulWidget
    implements NameProvider {
  static const String _name = "ValueListenableBuilder";
  @override
  String get name => _name;

  const ValueListenableBuilderPage({super.key});

  @override
  State<ValueListenableBuilderPage> createState() => _ValueListenableState();
}

class _ValueListenableState extends State<ValueListenableBuilderPage> {
  // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    // 添加 + 按钮不会触发整个 _ValueListenableState 组件的 build
    // print('build');
    return Scaffold(
      body: Column(
        children: [
          const Text("ValueListenableBuilder:实现任意流向的数据共享&最小化重建子组件"),
          Divider(),
          ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              // builder 方法只会在 _counter 变化时被调用
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child!,
                  Text(
                    '$value 次',
                    textScaler: TextScaler.linear(textScaleFactor),
                  ),
                ],
              );
            },
            valueListenable: _counter, // 监听的数据源
            // 不变的子组件。当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
            child: const Text(
              '点击了 ',
              textScaler: TextScaler.linear(textScaleFactor),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        // 点击后值 +1，触发 ValueListenableBuilder 重新构建
        onPressed: () => _counter.value += 1,
      ),
    );
  }
}
