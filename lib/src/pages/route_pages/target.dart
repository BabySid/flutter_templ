import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/route_names.dart';

class TargetRoutePage extends StatefulWidget {
  final Map arguments;
  final int id;
  const TargetRoutePage({
    super.key,
    this.arguments = const <String, dynamic>{},
    this.id = 999,
  });

  @override
  State<TargetRoutePage> createState() => _TargetRoutePageState();
}

class _TargetRoutePageState extends State<TargetRoutePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 默认禁止返回
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          // 如果预期的路由pop，则直接返回
          return;
        }
        //  处理返回事件
        var value = await _handleBackNavigation(context);
        if (value == "GoBack" && context.mounted) {
          Navigator.of(context).pop("PopScope $value ");
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "路由传入的动态参数为: ${widget.arguments.toString()} ${widget.id}",
              style: const TextStyle(
                // 重置。否则会用父级的style
                fontSize: 14,
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pop("路由返回的数据: ${widget.arguments.toString()}");
              },
              child: const Text("基本路由返回"),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(targetRoute2rdPage);
              },
              child: const Text("继续路由到新的页面"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _handleBackNavigation(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to leave this page?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop("No");
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop("GoBack");
              },
            ),
          ],
        );
      },
    );

    return result as String;
  }
}
