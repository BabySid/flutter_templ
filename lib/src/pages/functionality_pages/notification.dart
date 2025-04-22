import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class NotificationPage extends StatefulWidget implements NameProvider {
  static const String _name = "Notification";
  @override
  String get name => _name;

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: NotificationListener<_MyNotification>(
            onNotification: (notification) {
              setState(() {
                _msg += "${notification.msg} ";
              });
              return true; // 返回true表示通知被处理了，不会继续向上冒泡
            },
            child: Column(
              children: [
                Text(_msg),
                Builder(
                  // NotificationListener是监听的子树，所以通过Builder来构建ElevatedButton，来获得按钮位置的context
                  builder: (context) {
                    return ElevatedButton(
                      //按钮点击时分发通知
                      onPressed: () => _MyNotification("Hi").dispatch(context),
                      child: Text("发送通知"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyNotification extends Notification {
  _MyNotification(this.msg);
  final String msg;
}
