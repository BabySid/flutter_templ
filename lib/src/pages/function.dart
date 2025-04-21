import 'package:flutter/material.dart';
import 'package:flutter_teml/src/pages/functionality_pages/async_update_ui.dart';
import 'package:flutter_teml/src/pages/functionality_pages/color_and_theme.dart';
import 'package:flutter_teml/src/pages/functionality_pages/value_listenable_builder.dart';

import 'package:flutter_teml/src/utils/name_provider.dart';

class FunctionalityPage extends StatefulWidget {
  const FunctionalityPage({super.key});

  @override
  State<FunctionalityPage> createState() => _FunctionalityPageState();
}

class _FunctionalityPageState extends State<FunctionalityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    const ColorAndThemePage(),
    const ValueListenableBuilderPage(),
    const AsyncUpdateUIPage(),
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
          controller: _tabController,
          tabs: tabBar,
        ),
      ),
      body: TabBarView(controller: _tabController, children: tabBarView),
    );
  }
}
