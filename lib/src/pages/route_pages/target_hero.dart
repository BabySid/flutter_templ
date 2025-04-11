import 'package:flutter/material.dart';

class TargetHeroPage extends StatefulWidget {
  final Map arguments;
  const TargetHeroPage({super.key, this.arguments = const <String, dynamic>{}});

  @override
  State<TargetHeroPage> createState() => _TargetHeroPageState();
}

class _TargetHeroPageState extends State<TargetHeroPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "路由传入的动态参数为: ${widget.arguments.toString()}",
            style: TextStyle(
              // 重置。否则会用父级的style
              fontSize: 14,
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, "${widget.arguments["key"]}");
            },
            child: Hero(
              tag: widget.arguments["key"],
              child: Container(
                color: Colors.black,
                width: 300,
                height: 300,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset("assets/images/img.jpg"),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
