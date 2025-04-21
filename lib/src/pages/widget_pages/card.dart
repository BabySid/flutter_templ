import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/keep_alive_wapper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetCardPage extends StatelessWidget implements NameProvider {
  static const String _name = "Card";
  @override
  String get name => _name;

  const WidgetCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeepAliveWrapper(
        child: ListView(
          children: [
            FractionallySizedBox(
              widthFactor: 0.3, // 占用父容器一半的宽度
              child: Card(
                shape: const RoundedRectangleBorder(
                  //Card的阴影效果
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                elevation: 20, //阴影值的深度
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        "Card-title",
                        style: TextStyle(fontSize: 30),
                      ),
                      subtitle: const Text("Card-subtitle"),
                    ),
                    Divider(),
                    ListTile(
                      title: const Text("Card-FractionallySizedBox.0.3"),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            LayoutBuilder(
              builder: (context, constraints) {
                double width =
                    constraints.maxWidth < 600
                        ? 300
                        : constraints.maxWidth * 0.5;
                return SizedBox(
                  width: width,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 20,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                            "Card-title",
                            style: TextStyle(fontSize: 30),
                          ),
                          subtitle: const Text("Card-subtitle"),
                        ),
                        Divider(),
                        ListTile(title: Text("Card-LayoutBuilder.$width")),
                      ],
                    ),
                  ),
                );
              },
            ),
            Divider(),
            Center(
              // Center 和 Align 会根据其子 widget 的大小来调整自己的大小,它们允许子 widget 选择自己的大小，然后将子 widget 放置在可用空间的中心或指定位置。
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 20,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(
                          "assets/images/bg1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/img.jpg"),
                        ),
                        title: Text("xxxxxxxxx"),
                        subtitle: Text("xxxxxxxxx"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
