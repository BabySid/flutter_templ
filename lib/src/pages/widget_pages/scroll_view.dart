import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/sliver_header_delegate.dart';

class WidgetScrollViewPage extends StatefulWidget implements NameProvider {
  static const String _name = "ScrollView";

  @override
  String get name => _name;

  const WidgetScrollViewPage({super.key});

  @override
  State<WidgetScrollViewPage> createState() => _WidgetScrollViewPageState();
}

class _WidgetScrollViewPageState extends State<WidgetScrollViewPage> {
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
    // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
    // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
    // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
    var listView = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
    );
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // 滑动到顶端时会固定住
            expandedHeight: 450.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "./assets/images/bg1.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            // 如果 CustomScrollView 有孩子也是一个完整的可滚动组件且它们的滑动方向一致，
            //则 CustomScrollView 不能正常工作。要解决这个问题，可以使用 NestedScrollView
            // 所以这里的PageView可以使用是因为默认的滚动方向是横向，而CustomScrollView默认是纵向
            // 如果将PageView的滚动方向也设置为纵向，则外层的CustomScrollView无法生效。因为滚动优先子元素
            child: SizedBox(
              height: 100,
              child: PageView(
                scrollDirection: Axis.vertical,
                children: [
                  Text(
                    "1",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "2",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "3",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              //Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 2.0,
                mainAxisExtent: 50,
              ),
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int index,
              ) {
                //创建子widget
                return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              }, childCount: 20),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              //创建列表项
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('list item $index'),
              );
            }, childCount: 20),
          ),
          listView,
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              //有最大和最小高度
              maxHeight: 80,
              minHeight: 50,
              child: buildHeader(1),
            ),
          ),
          listView,
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.fixedHeight(
              //固定高度
              height: 50,
              child: buildHeader(2),
            ),
          ),
          listView,
        ],
      ),
    );
  }
}

Widget buildHeader(int i) {
  return Container(
    color: Colors.lightBlue.shade200,
    alignment: Alignment.centerLeft,
    child: Text("PersistentHeader $i"),
  );
}
