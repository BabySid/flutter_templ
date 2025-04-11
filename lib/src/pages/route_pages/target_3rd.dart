import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/route_names.dart';
import 'package:flutter_teml/src/pages/home.dart';

class TargetRoute3Page extends StatefulWidget {
  const TargetRoute3Page({super.key});

  @override
  State<TargetRoute3Page> createState() => _TargetRoute2PageState();
}

class _TargetRoute2PageState extends State<TargetRoute3Page> {
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
            "路由到新的页面，第三页",
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
              // Navigator.of(
              //   context,
              // ).pushNamedAndRemoveUntil(homePath, (route) => false);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(tabIndex: 1),
                ),
                (route) => false,
              );
            },
            child: const Text("返回到路由首页"),
          ),
          Divider(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("返回上一页: target页"),
          ),
        ],
      ),
    );
  }
}
