import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/route_names.dart';

class TargetRoute2Page extends StatefulWidget {
  const TargetRoute2Page({super.key});

  @override
  State<TargetRoute2Page> createState() => _TargetRoute2PageState();
}

class _TargetRoute2PageState extends State<TargetRoute2Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("路由页面")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "路由到新的页面，第二页",
            style: TextStyle(
              // 重置。否则会用父级的style
              fontSize: 14,
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(targetRoute3rdPage);
            },
            child: const Text("继续跳转到最后一页，且无法返回到当前的第二页"),
          ),
        ],
      ),
    );
  }
}
