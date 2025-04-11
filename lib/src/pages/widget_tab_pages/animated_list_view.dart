import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/keep_alive_wapper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetAnimatedListViewPage extends StatefulWidget
    implements NameProvider {
  static const String _name = "AnimatedListView";

  @override
  String get name => _name;

  const WidgetAnimatedListViewPage({super.key});

  @override
  State<WidgetAnimatedListViewPage> createState() =>
      _WidgetAnimatedListViewPageState();
}

class _WidgetAnimatedListViewPageState extends State<WidgetAnimatedListViewPage>
    with SingleTickerProviderStateMixin {
  final _globalKey = GlobalKey<AnimatedListState>();
  bool flag = true;
  List<String> list = ["第一条", "第二条"];

  Widget _buildItem(index) {
    return ListTile(
      key: ValueKey(index),
      title: Text(list[index]),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          //执行删除
          _deleteItem(index);
        },
      ),
    );
  }

  _deleteItem(index) {
    if (flag == true) {
      flag = false;
      //执行删除
      _globalKey.currentState!.removeItem(index, (context, animation) {
        //animation的值是从1到0
        var removeItem = _buildItem(index);
        list.removeAt(index); //数组中删除数据
        return ScaleTransition(
          // opacity: animation,
          scale: animation,
          child: removeItem, //删除的时候执行动画的元素
        );
      });
      //解决快速删除的bug
      Timer.periodic(const Duration(milliseconds: 500), (timer) {
        flag = true;
        timer.cancel();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              list.add("新增的数据");
              _globalKey.currentState!.insertItem(list.length - 1);
            },
            icon: const Icon(Icons.add),
            label: const Text("增加"),
          ),
          Divider(),
          Expanded(
            child: AnimatedList(
              key: _globalKey,
              initialItemCount: list.length,
              itemBuilder: ((context, index, animation) {
                //animation的值是从0到1
                // return FadeTransition(opacity: animation, child: _buildItem(index));
                return ScaleTransition(
                  scale: animation,
                  child: _buildItem(index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
