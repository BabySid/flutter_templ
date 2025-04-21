import 'package:flutter/material.dart';
import 'package:flutter_teml/src/pages/page_view_pages/full_page_view.dart';
import 'package:flutter_teml/src/pages/page_view_pages/page_view.dart';
import 'package:flutter_teml/src/pages/page_view_pages/swiper_page_view.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({super.key});

  @override
  State<PageViewPage> createState() => _PageViewState();
}

class _PageViewState extends State<PageViewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const BasicPageViewPage(),
    const FullPageViewPage(),
    const SwiperPageViewPage(),
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
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          headlineLarge: const TextStyle(
            color: Colors.green,
            fontSize: 20,
            decoration: TextDecoration.overline,
          ),
          headlineMedium: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
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
            controller: _tabController,
            tabs: tabBar,
          ),
        ),
        body: TabBarView(controller: _tabController, children: tabBarView),
      ),
    );
  }
}
