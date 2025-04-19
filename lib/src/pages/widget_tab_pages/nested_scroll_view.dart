import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetNestedScrollViewPage extends StatefulWidget
    implements NameProvider {
  static const String _name = "NestedScrollView";

  @override
  String get name => _name;

  const WidgetNestedScrollViewPage({super.key});

  @override
  State<WidgetNestedScrollViewPage> createState() =>
      _WidgetNestedScrollViewPageState();
}

class _WidgetNestedScrollViewPageState
    extends State<WidgetNestedScrollViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('NestedListView'),
                collapsedHeight: 60,
                expandedHeight: 450,
                floating: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Demo'),
                  background: Image.asset(
                    "./assets/images/bg1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                //pinned: true, // 固定在顶部
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 56, //列表项高度固定
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => ListTile(title: Text('$index')),
                    childCount: 30,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
