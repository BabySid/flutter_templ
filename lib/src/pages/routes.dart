import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/route_names.dart';
import 'package:flutter_teml/src/pages/route_pages/target.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late Text _showResult;

  @override
  void initState() {
    super.initState();

    _showResult = Text('路由页面值显示区');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("路由页面")),
      body: ListView(
        children: [
          Center(child: _showResult),

          ElevatedButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const TargetRoutePage();
                  },
                ),
              );
              setState(() {
                _showResult = Text("基本路由跳转 => $result");
              });
            },
            child: const Text("基本路由跳转"),
          ),

          ElevatedButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const TargetRoutePage(
                      arguments: {'key': 12345},
                      id: 888,
                    );
                  },
                ),
              );
              setState(() {
                _showResult = Text("基本路由跳转:附带传参 => $result");
              });
            },
            child: const Text("基本路由跳转:附带传参"),
          ),

          ElevatedButton(
            onPressed: () async {
              var result = await Navigator.pushNamed(context, targetRoutePage);
              setState(() {
                _showResult = Text("命名路由跳转 => $result");
              });
            },
            child: const Text("命名路由跳转"),
          ),

          ElevatedButton(
            onPressed: () async {
              var result = await Navigator.pushNamed(
                context,
                targetRoutePage,
                arguments: {'key': 23456},
              );
              setState(() {
                _showResult = Text("命名路由跳转:附带传参 => $result");
              });
            },
            child: const Text("命名路由跳转:附带传参"),
          ),

          GestureDetector(
            onTap: () async {
              var result = await Navigator.pushNamed(
                context,
                targetHeroPage,
                arguments: {"key": "tagOfHero"},
              );
              setState(() {
                _showResult = Text("Hero跳转 => $result");
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: "tagOfHero",
                    child: Image.asset(
                      "assets/images/avatar.jpg",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "👮",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              var result = await Navigator.pushNamed(context, loginPath);
              setState(() {
                _showResult = Text("登录页面 => $result");
              });
            },
            child: const Text("登录页面"),
          ),
        ],
      ),
    );
  }
}
