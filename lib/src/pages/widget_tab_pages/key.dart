import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/keep_alive_wapper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetKeyPage extends StatefulWidget implements NameProvider {
  static const String _name = "Key";
  @override
  String get name => _name;

  const WidgetKeyPage({super.key});

  @override
  State<WidgetKeyPage> createState() => _WidgetKeyPageState();
}

class _WidgetKeyPageState extends State<WidgetKeyPage> {
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();

  String _result = "";

  // 默认情况下面，当Flutter同一个 Widget的大小，顺序变化的时候，FLutter不会改变Widget的state。所以没有设置key，Box的状态不会变
  // List<Widget> list = [
  //   // shuffle需要修改，所以不能为const
  //   // LocalKey 仅仅对当前的组件树有效，当把column换成row时（横屏切换到竖屏)，widget的状态就丢失了。因此就得需要使用globalKey
  //   // 查看屏幕状态时：MediaQuery.of(context).orientation==Orientation.portrait
  //   Box(key: const ValueKey(1), color: Colors.blue),
  //   Box(key: const ObjectKey(Box(color: Colors.red)), color: Colors.red),
  //   Box(
  //       key: UniqueKey(), // 程序自动生成
  //       color: Colors.orange),
  // ];

  List<Widget> list = [];
  @override
  void initState() {
    super.initState();

    list = [
      Box(key: _key1, color: Colors.blue),
      Box(key: _key2, color: Colors.red),
      Box(
        key: _key3, //程序自动生成一个key
        color: Colors.orange,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeepAliveWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  list.shuffle();
                });
              },
              child: const Text("Shuffle"),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                //1、获取子组件的状态 调用子组件的属性
                var state = (_key1.currentState as _BoxState);
                state.run();

                //2、获取子组件的属性
                var box = (_key2.currentWidget as Box);

                //3、获取子组件渲染的属性
                var renderBox =
                    (_key3.currentContext!.findRenderObject() as RenderBox);

                setState(() {
                  state._count++;
                  _result = "${box.color}, ${renderBox.size}";
                });
              },
              child: const Text("Run"),
            ),
            Divider(),
            Text("key 运行结果: $_result"),
            Divider(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//子Widget
class Box extends StatefulWidget {
  final Color color;
  const Box({super.key, required this.color});
  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  int _count = 0;
  void run() {
    setState(() {
      _count += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(widget.color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          ),
        ),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: Text(
          "$_count",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
