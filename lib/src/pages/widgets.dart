import 'package:flutter/material.dart';
import 'package:flutter_teml/src/pages/widget_pages/animated_list_view.dart';
import 'package:flutter_teml/src/pages/widget_pages/button.dart';
import 'package:flutter_teml/src/pages/widget_pages/card.dart';
import 'package:flutter_teml/src/pages/widget_pages/container.dart';
import 'package:flutter_teml/src/pages/widget_pages/custom_widget.dart';
import 'package:flutter_teml/src/pages/widget_pages/dialog.dart';
import 'package:flutter_teml/src/pages/widget_pages/grid_view.dart';
import 'package:flutter_teml/src/pages/widget_pages/icon_and_font.dart';
import 'package:flutter_teml/src/pages/widget_pages/img.dart';
import 'package:flutter_teml/src/pages/widget_pages/key.dart';
import 'package:flutter_teml/src/pages/widget_pages/layout.dart';
import 'package:flutter_teml/src/pages/widget_pages/list_view.dart';
import 'package:flutter_teml/src/pages/widget_pages/list_view_h.dart';
import 'package:flutter_teml/src/pages/widget_pages/nested_scroll_view.dart';
import 'package:flutter_teml/src/pages/widget_pages/paint_canvas.dart';
import 'package:flutter_teml/src/pages/widget_pages/row_column_flex.dart';
import 'package:flutter_teml/src/pages/widget_pages/progress_indicator.dart';
import 'package:flutter_teml/src/pages/widget_pages/scroll_view.dart';
import 'package:flutter_teml/src/pages/widget_pages/stack_align_pos.dart';
import 'package:flutter_teml/src/pages/widget_pages/state.dart';
import 'package:flutter_teml/src/pages/widget_pages/text.dart';
import 'package:flutter_teml/src/pages/widget_pages/water_mark.dart';
import 'package:flutter_teml/src/pages/widget_pages/wrap.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetsPage extends StatefulWidget {
  const WidgetsPage({super.key});

  @override
  State<WidgetsPage> createState() => _WidgetsState();
}

class _WidgetsState extends State<WidgetsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const WaterMarkPage(),
    const CustomWidgetPage(),
    const CustomPaintAndCanvasPage(),
    const WidgetTextPage(),
    const WidgetContainerPage(),
    const WidgetImgPage(),
    const WidgetListViewPage(),
    WidgetListViewHPage(),
    const WidgetAnimatedListViewPage(),
    const WidgetIconFontPage(),
    WidgetGridPage(),
    const WidgetRowColumnFlexPage(),
    const WidgetStackAlignPosPage(),
    const WidgetCardPage(),
    const WidgetButtonPage(),
    const WidgetWrapPage(),
    const WidgetDialogPage(),
    const WidgetKeyPage(),
    const WidgetStatePage(),
    const WidgetProgressIndicatorPage(),
    const WidgetLayoutPage(),
    const WidgetScrollViewPage(),
    const WidgetNestedScrollViewPage(),
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

    _tabController.addListener(() {
      if (_tabController.animation!.value == _tabController.index) {
        // todo log pannel
        print("_WidgetsState._tabController : ${_tabController.index}");
      }
    });
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
