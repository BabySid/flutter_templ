import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetWrapPage extends StatelessWidget implements NameProvider {
  static const String _name = "Wrap&Flow";
  @override
  String get name => _name;

  const WidgetWrapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            children: [
              Text("热搜", style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const Divider(),
          Wrap(
            spacing: 5, // 水平间距
            runSpacing: 5, // 垂直间距
            alignment: WrapAlignment.start,
            children: [
              MyItem("女装", onPressed: () {}),
              MyItem("笔记本", onPressed: () {}),
              MyItem("玩具", onPressed: () {}),
              MyItem("文学", onPressed: () {}),
              MyItem("女装", onPressed: () {}),
              MyItem("时尚", onPressed: () {}),
              MyItem("男装", onPressed: () {}),
              MyItem("xxxx", onPressed: () {}),
              MyItem("手机", onPressed: () {}),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('A'),
                ),
                label: Text('Hamilton'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('M'),
                ),
                label: Text('Lafayette'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('H'),
                ),
                label: Text('Mulligan'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('J'),
                ),
                label: Text('Laurens'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("历史记录", style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const Divider(),
          Column(
            children: const [
              ListTile(title: Text("女装")),
              Divider(),
              ListTile(title: Text("手机")),
              Divider(),
              ListTile(title: Text("电脑")),
              Divider(),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: OutlinedButton.icon(
              //自适应
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.black45),
              ),
              onPressed: () {},
              icon: const Icon(Icons.delete),
              label: const Text("清空历史记录"),
            ),
          ),
          Divider(),
          const Text("Flow"),
          Flow(
            delegate: MyFlowDelegate(margin: EdgeInsets.all(10.0)),
            children: <Widget>[
              Container(width: 80.0, height: 80.0, color: Colors.red),
              Container(width: 80.0, height: 80.0, color: Colors.green),
              Container(width: 80.0, height: 80.0, color: Colors.blue),
              Container(width: 80.0, height: 80.0, color: Colors.yellow),
              Container(width: 80.0, height: 80.0, color: Colors.brown),
              Container(width: 80.0, height: 80.0, color: Colors.purple),
            ],
          ),
        ],
      ),
    );
  }
}

class MyItem extends StatelessWidget {
  final String text; //按钮的文字
  final void Function()? onPressed; //方法
  const MyItem(this.text, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(241, 223, 219, 219),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.black45),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  final EdgeInsets margin;

  MyFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，宽度、高度指定为100，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(100, 100.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
