import 'dart:async';

import 'package:flutter/cupertino.dart';
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

  void _customSizeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, //点击遮罩关闭对话框
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          // showDialog中已经给对话框设置了最小宽度约束
          // 可以使用UnconstrainedBox先抵消showDialog对宽度的约束
          child: SizedBox(
            width: 200,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text("正在加载，请稍后..."),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _datePickerDialog() async {
    var date = DateTime.now();
    var result = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(
        //未来30天可选
        Duration(days: 30),
      ),
    );
    setState(() {
      _showResult = Text("_datePickerDialog => $result");
    });
  }

  void _cupertinoDatePickerDialog() async {
    var date = DateTime.now();
    var result = await showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(Duration(days: 30)),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              //print(value);
            },
          ),
        );
      },
    );
    setState(() {
      _showResult = Text("_CupertinoDatePickerDialog => $result");
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

  void _showToast() {
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
          onTap: (bool param) {
            Navigator.of(context).pop("我是自定义dialog关闭的事件:$param");
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

  void _showDialog(BuildContext context) async {
    var result = await showDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("请选择")),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.of(context).pop(index),
                  );
                },
              ),
            ),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );

    setState(() {
      _showResult = Text("_showDialog => $result");
    });
  }

  void _showGeneralDialog(BuildContext context) async {
    var result = await _generalDialog(
      barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    setState(() {
      _showResult = Text("_showDialog => $result");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              onPressed: _customSizeDialog,
              child: const Text('alert弹出框-控制大小 '),
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
            // fluttertoast
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
            Divider(),
            ElevatedButton(
              onPressed: () => {_showDialog(context)},
              child: const Text('Dialog(延迟加载)'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () => {_showGeneralDialog(context)},
              child: const Text('_showGeneralDialog'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () => {_datePickerDialog()},
              child: const Text('_datePickerDialog'),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () => {_cupertinoDatePickerDialog()},
              child: const Text('_datePickerDialog(IOS)'),
            ),
          ],
        ),
      ),
    );
  }
}

typedef ParamCallback = void Function(bool param);

class _CustomDialog extends StatefulWidget {
  final String title;
  final String content;
  final ParamCallback onTap;

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
  int _countdown = 10; // 倒计时 10 秒
  var withTree = false;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("一个复选框"),
              // 使用StatefulBuilder或者通过Builder来获得构建Checkbox的`context`，
              // 这是一种常用的缩小`context`范围的方式
              // StatefulBuilder(
              //   builder: (context, setState) {
              //     return Checkbox(
              //       value: withTree,
              //       onChanged: (bool? value) {
              //         setState(() {
              //           withTree = !withTree;
              //         });
              //       },
              //     );
              //   },
              // ),
              Builder(
                builder: (BuildContext context) {
                  return Checkbox(
                    value: withTree,
                    onChanged: (bool? value) {
                      (context as Element).markNeedsBuild();
                      withTree = !withTree;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onTap(withTree);
            _timer.cancel();
          },
          child: Text("确定"),
        ),
      ],
    );
  }
}

Future<T?> _generalDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  required WidgetBuilder builder,
  ThemeData? theme,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext buildContext,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Theme(data: theme, child: pageChild);
          },
        ),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87, // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
    child: child,
  );
}
