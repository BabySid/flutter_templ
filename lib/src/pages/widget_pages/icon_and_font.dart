import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/my_icons.dart';

class WidgetIconFontPage extends StatelessWidget implements NameProvider {
  static const String _name = "Icon&Font";
  @override
  String get name => _name;

  const WidgetIconFontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.red, size: 40),
            SizedBox(height: 10),
            Icon(Icons.home),
            SizedBox(height: 10),
            Icon(Icons.category),
            SizedBox(height: 10),
            Icon(Icons.shop, color: Colors.brown),
            SizedBox(height: 10),
            Icon(MyIcons.bluetooth, color: Colors.blue),
            SizedBox(height: 10),
            Icon(MyIcons.wechat, color: Colors.green),
            Divider(),
            const Text(
              "SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，因为不支持基于 Sliver 的延迟加载模型",
              style: TextStyle(fontFamily: "AliMamaDaoLi", fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}
