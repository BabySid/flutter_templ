import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class ColorAndThemePage extends StatefulWidget implements NameProvider {
  static const String _name = "Color&Theme";
  @override
  String get name => _name;

  const ColorAndThemePage({super.key});

  @override
  State<ColorAndThemePage> createState() => _ColorAndThemePageState();
}

class _ColorAndThemePageState extends State<ColorAndThemePage> {
  var _themeColor = Colors.lightBlue; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
        iconTheme: IconThemeData(color: _themeColor), //用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "主题测试",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              //根据背景色亮度来确定Title颜色
              color:
                  _themeColor.computeLuminance() < 0.3
                      ? Colors.yellow
                      : Colors.purple,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("颜色跟随主题"),
              ],
            ),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色固定黑色"),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              () => //切换主题
                  setState(
                () =>
                    _themeColor =
                        _themeColor == Colors.lightBlue
                            ? Colors.deepOrange
                            : Colors.lightBlue,
              ),
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}
