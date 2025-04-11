import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/helper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetDialogPage extends StatefulWidget implements NameProvider {
  static const String _name = "Dialog";
  @override
  String get name => _name;

  const WidgetDialogPage({super.key});

  @override
  State<WidgetDialogPage> createState() => _WidgetDialogPageState();
}

class _WidgetDialogPageState extends State<WidgetDialogPage> {
  late FToast fToast;
  late Text _showResult;

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    _showResult = Text('对话框结果值显示区');
  }

  @override
  void dispose() {
    super.dispose();

    // To remove present shwoing toast
    fToast.removeCustomToast();

    // To clear the queue
    fToast.removeQueuedCustomToasts();
  }

  void _alertDialog() async {
    var result = await showDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("提示信息!"),
          content: const Text("您确定要删除吗"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop("ok"); //点击按钮让AlertDialog消失
              },
              child: const Text("确定"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop("取消");
              },
              child: const Text("取消"),
            ),
          ],
        );
      },
    );

    setState(() {
      _showResult = Text("_alertDialog => $result");
    });
  }

  void _simpleDialog() async {
    var result = await showDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("请选择语言"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "汉语");
              },
              child: const Text("汉语"),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "英语");
              },
              child: const Text("英语"),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, "日语");
              },
              child: const Text("日语"),
            ),
            const Divider(),
          ],
        );
      },
    );

    setState(() {
      _showResult = Text("_simpleDialog => $result");
    });
  }

  void _modelBottomSheet() async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: const Text("分享"),
              onTap: () {
                Navigator.of(context).pop("分享");
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("收藏"),
              onTap: () {
                Navigator.of(context).pop("收藏");
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("取消"),
              onTap: () {
                Navigator.of(context).pop("取消");
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _showResult = Text("_modelBottomSheet => $result");
    });
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.check), SizedBox(width: 12.0), Text("自定义的Toast")],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 4),
      positionedToastBuilder: (context, child, gravity) => Center(child: child),
    );
  }

  void _customDialog() async {
    var result = await showDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        return _CustomDialog(
          title: "提示!",
          content: "我是一个内容",
          onTap: () {
            Navigator.of(context).pop("我是自定义dialog关闭的事件");
          },
        );
      },
    );

    setState(() {
      _showResult = Text("_customDialog => $result");
    });
  }

  void _showSnackBar(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final controller = scaffoldMessenger.showSnackBar(
      SnackBar(
        content: const Text("自定义 SnackBar"),
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          top: 100,
          bottom: MediaQuery.of(context).size.height * .1, // 屏幕高度
          left: 100,
          right: 100,
        ),
        action: SnackBarAction(
          label: '返回数据',
          onPressed: () {
            scaffoldMessenger.hideCurrentSnackBar(
              reason: SnackBarClosedReason.hide,
            );
          },
        ),
      ),
    );
    controller.closed.then(
      (result) => {
        setState(() {
          _showResult = Text("_showSnackBar => $result");
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _showResult,
          Divider(),
          ElevatedButton(
            onPressed: _alertDialog,
            child: const Text('alert弹出框-AlertDialog '),
          ),
          Divider(),
          ElevatedButton(
            onPressed: _simpleDialog,
            child: const Text('select弹出框-SimpleDialog'),
          ),
          Divider(),
          ElevatedButton(
            onPressed: _modelBottomSheet,
            child: const Text('ActionSheet底部弹出框'),
          ),
          Divider(),
          ElevatedButton(onPressed: _showToast, child: const Text('Toast')),
          Divider(),
          ElevatedButton(
            onPressed: _customDialog,
            child: const Text('自定义Dialog'),
          ),
          Divider(),
          ElevatedButton(
            onPressed: () => {_showSnackBar(context)},
            child: const Text('SnackBar'),
          ),
          // fluttertoast
        ],
      ),
    );
  }
}

class _CustomDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onTap;

  const _CustomDialog({
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  __CustomDialogState createState() => __CustomDialogState();
}

class __CustomDialogState extends State<_CustomDialog> {
  late Timer _timer;
  int _countdown = 3; // 倒计时 3 秒

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        if (mounted) Navigator.of(context).pop("超时自动关闭");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.content),
          SizedBox(height: 10),
          Text("$_countdown秒后自动关闭", style: TextStyle(color: Colors.grey)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onTap();
            _timer.cancel();
          },
          child: Text("确定"),
        ),
      ],
    );
  }
}
