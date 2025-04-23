import 'package:flutter/material.dart';
import 'package:flutter_teml/src/pages/animate_pages/animated_widget.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_container.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_opacity.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_padding.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_positioned.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_switcher.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_text_style.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  static const _tabs = [
    AnimatedWidgetPage(),
    MyAnimatedSwitcherPage(),
    MyAnimatedContainerPage(),
    MyAnimatedPaddingPage(),
    MyAnimatedOpacityPage(),
    MyAnimatedPositionedPage(),
    MyAnimatedTextStylePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // 使用DefaultTabController可以不用使用_tabController,还支持StatelessWidget
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            labelStyle: const TextStyle(fontSize: 16),
            isScrollable: true,
            indicatorColor: Colors.red,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            // indicator: BoxDecoration(
            //   color: Colors.blue,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            tabs:
                _tabs.whereType<NameProvider>().map((widget) {
                  return Text(widget.name);
                }).toList(),
          ),
        ),
        body: TabBarView(children: _tabs.toList()),
      ),
    );
  }
}
