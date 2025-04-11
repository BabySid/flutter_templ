import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetGridPage extends StatelessWidget implements NameProvider {
  static const String _name = "GridView";
  @override
  String get name => _name;

  WidgetGridPage({super.key});

  final List<Icon> _icons = [
    Icon(Icons.pedal_bike),
    Icon(Icons.home),
    Icon(Icons.ac_unit),
    Icon(Icons.search),
    Icon(Icons.settings),
    Icon(Icons.airport_shuttle),
    Icon(Icons.all_inclusive),
    Icon(Icons.beach_access),
    Icon(Icons.cake),
    Icon(Icons.circle),
  ];
  Widget _getGridItem(BuildContext context, int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent, width: 1),
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: 6,
                child: Center(
                  child: Icon(
                    _icons[index].icon,
                    size: constraints.maxHeight * 0.5,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Center(
                  child: Text(
                    _icons[index].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: constraints.maxHeight * 0.12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getGridItems() {
    return _icons.map((value) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent, width: 1),
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 6,
                  child: Center(
                    child: Icon(value.icon, size: constraints.maxHeight * 0.5),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Center(
                    child: Text(
                      value.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: constraints.maxHeight * 0.12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 5, //一行的Widget数量
              padding: const EdgeInsets.all(3),
              crossAxisSpacing: 3, //水平子Widget之间间距
              mainAxisSpacing: 3, //垂直子Widget之间间距
              childAspectRatio: 1, //宽高比
              children: _getGridItems(),
            ),
          ),
          Divider(),

          // GridView.extent根据横轴长度(maxCrossAxisExtent)做控制，而不是根据count(crossAxisCount)做控制
          Expanded(
            child: GridView.extent(
              shrinkWrap: true, // 会收缩尺寸到刚好容纳其子元素
              physics: NeverScrollableScrollPhysics(), // 禁用滚动条
              maxCrossAxisExtent: 100, //一行的Widget长度
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10, //水平子Widget之间间距
              mainAxisSpacing: 10, //垂直子Widget之间间距
              childAspectRatio: 1.2, //宽高比
              children: _getGridItems(),
            ),
          ),

          Divider(),
          Expanded(
            child: GridView.builder(
              // SliverGridDelegateWithMaxCrossAxisExtent 为对应的extent的模式
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, //一行的Widget数量
                crossAxisSpacing: 10, //水平子Widget之间间距
                mainAxisSpacing: 10, //垂直子Widget之间间距
                childAspectRatio: 1.2, //宽高比
              ),
              itemCount: _icons.length,
              itemBuilder: (context, index) => _getGridItem(context, index),
            ),
          ),
        ],
      ),
    );
  }
}
