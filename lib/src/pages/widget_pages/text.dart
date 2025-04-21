import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/link_text_span.dart' show LinkText;

class WidgetTextPage extends StatefulWidget implements NameProvider {
  static const String _name = "Text";
  @override
  String get name => _name;

  const WidgetTextPage({super.key});

  @override
  State<WidgetTextPage> createState() => _WidgetTextPageState();
}

class _WidgetTextPageState extends State<WidgetTextPage> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _contController = TextEditingController();

  final FocusNode _unameFocus = FocusNode();
  final FocusNode _passwdFocus = FocusNode();
  FocusScopeNode? _focusScopeNode;

  @override
  void initState() {
    super.initState();

    //监听输入改变
    _unameController.addListener(() {
      if (_unameController.text.isEmpty) {
        _contController.text = "用户&密码输入结果显示区";
        return;
      }
      _contController.text =
          "${_unameController.text}:${_passwdController.text}";
    });
  }

  @override
  void dispose() {
    _unameController.dispose();
    _passwdController.dispose();
    _contController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "一个文本组件. 当前屏幕尺寸为: $size",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 30.0, color: Colors.teal),
              ),
            ),
            Divider(),
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.topCenter,
              child: Text(
                "Hello World" * 5,
                textAlign: TextAlign.center,
                textScaler: TextScaler.linear(2),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.yellow,
                gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                  ),
                ],
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              transform: Matrix4.rotationZ(0.1),
              child: const Text(
                "复杂的文本组件,太多的文本将不再显示",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textScaler: TextScaler.linear(1.8),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  backgroundColor: Colors.grey,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationStyle: TextDecorationStyle.dashed,
                  letterSpacing: 5.0,
                ),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              width: 300,
              color: Colors.teal,
              child: Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('沿Y轴倾斜变换'),
                ),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              color: Colors.teal,
              width: 300,
              child: Transform.translate(
                offset: Offset(-50.0, 10.0),
                child: Text("Transform.translate"),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              color: Colors.teal,
              width: 300,
              height: 300,
              child: Transform.rotate(
                angle: math.pi / 2,
                child: Text("Transform.rotate"),
              ),
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              color: Colors.teal,
              width: 300,
              height: 100,
              child: Transform.scale(
                scale: 1.5,
                child: Text("Transform.scale"),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Transform.scale(
                    scale: 0.5,
                    child: Text("Transform.scale"),
                  ),
                ),
                Text(
                  "Transform发生在绘制而不是布局阶段",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度(1/4圈)
                    child: Text("RotatedBox-90度"),
                  ),
                ),
                Text(
                  "RotatedBox发生在布局而不是绘制阶段",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ),
              ],
            ),
            Divider(),
            const LinkText(
              url: "https://flutterchina.club",
              displayText: "RichText",
            ),

            Divider(),
            SizedBox(
              height: 100,
              width: 300,
              child: TextField(
                maxLength: null,
                enabled: false,
                controller: _contController,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 300,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _unameController,
                    autofocus: true,
                    focusNode: _unameFocus,
                    decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person),
                      // 未获得焦点下划线设为灰色
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      //获得焦点下划线设为蓝色
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    controller: _passwdController,
                    focusNode: _passwdFocus,
                    decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      prefixIcon: Icon(Icons.lock),
                      border: InputBorder.none, // 隐藏下划线
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _focusScopeNode ??= FocusScope.of(context);
                _focusScopeNode!.requestFocus(_passwdFocus);
                // _passwdFocus.unfocus(); // 失去焦点
              },
              child: const Text("焦点切换到密码输入"),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
