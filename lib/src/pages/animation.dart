import 'package:flutter/material.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_container.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_opacity.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_padding.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_positioned.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_switcher.dart';
import 'package:flutter_teml/src/pages/animate_pages/animation_text_style.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const MyAnimatedSwitcherPage(),
    const MyAnimatedContainerPage(),
    const MyAnimatedPaddingPage(),
    const MyAnimatedOpacityPage(),
    const MyAnimatedPositionedPage(),
    const MyAnimatedTextStylePage(),
  ];

  late List<Widget> tabBar;
  late List<Widget> tabBarView;

  void initTabBar() {
    tabBar =
        _tabs.whereType<NameProvider>().map((widget) {
          return Text(widget.name);
        }).toList();
  }

  void initTabBarView() {
    tabBarView = _tabs.toList();
  }

  @override
  void initState() {
    super.initState();

    initTabBar();
    initTabBarView();
    assert(tabBarView.length == tabBar.length, "values must eq");

    _tabController = TabController(length: tabBar.length, vsync: this);

    // _tabController.addListener(() {
    //   if (_tabController.animation!.value == _tabController.index) {
    //     // todo log pannel
    //     print("_WidgetsState._tabController : ${_tabController.index}");
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          controller: _tabController,
          tabs: tabBar,
        ),
      ),
      body: TabBarView(controller: _tabController, children: tabBarView),
    );
  }
}
