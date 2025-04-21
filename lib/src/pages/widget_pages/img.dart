import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetImgPage extends StatelessWidget implements NameProvider {
  static const String _name = "Image&Clip";
  @override
  String get name => _name;

  const WidgetImgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                // 修饰Container
                color: Colors.teal,
              ),
              child: Image.asset("assets/images/avatar.jpg", fit: BoxFit.cover),
            ),
            Divider(),
            // 基于Container的decoration实现圆形头像
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Transform.scale(
                scale: 1, // 缩放。可以去掉。直接使用ClipRRect
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/avatar.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                  child: Image.asset(
                    "assets/images/avatar.jpg",
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
                Text("溢出部分保留", style: TextStyle(color: Colors.green)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, //宽度设为原来宽度一半
                    child: Image.asset(
                      "assets/images/avatar.jpg",
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                Text("溢出部分裁剪", style: TextStyle(color: Colors.green)),
              ],
            ),
            Divider(),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(color: Colors.teal),
              child: ClipRect(
                clipper: _MyClipper(),
                child: Image.asset(
                  "assets/images/avatar.jpg",
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Divider(),
            // 基于Container的DecorationImage实现圆形头像
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage("assets/images/avatar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Divider(),
            // 基于ClipOval实现圆形头像
            ClipOval(
              child: Image.asset(
                "assets/images/img.jpg",
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            Divider(),
            // 基于CircleAvatr实现圆形头像
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/img.jpg"),
              radius: 110,
            ),
            Divider(),
            // 基于CircleAvatr实现圆形头像，且设置边框效果
            CircleAvatar(
              radius: 110,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/img.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 裁剪和Transform一样是在绘制阶段，而不是布局阶段
class _MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTRB(50.0, 50.0, 150.0, 150.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
