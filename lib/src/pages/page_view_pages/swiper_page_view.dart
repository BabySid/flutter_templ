import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

// 循环加载，无限轮播
class SwiperPageViewPage extends StatefulWidget implements NameProvider {
  static const String _name = "SwiperPageView";
  @override
  String get name => _name;

  const SwiperPageViewPage({super.key});

  @override
  State<SwiperPageViewPage> createState() => _SwiperPageViewPageState();
}

class _SwiperPageViewPageState extends State<SwiperPageViewPage> {
  List<Widget> list = [];
  int _currentIndex = 0;

  late PageController _pageController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    list.add(Image.asset("assets/images/avatar.jpg"));
    list.add(Image.asset("assets/images/bg1.png"));
    list.add(Image.asset("assets/images/bg2.png"));

    _pageController = PageController(initialPage: 0);

    timer = Timer.periodic(const Duration(seconds: 5), (t) {
      _pageController.animateToPage(
        (_currentIndex + 1) % list.length,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 500,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index % list.length;
                });
              },
              itemCount: 100,
              itemBuilder: (context, index) {
                return list[index % list.length];
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0, //设置 left:0 right:0就会站满整行
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(list.length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(15),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.red : Colors.grey,
                        shape: BoxShape.circle, //圆
                        // borderRadius: BorderRadius.circular(5) //圆
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
