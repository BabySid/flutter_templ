import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/horizontal_scroll_wapper.dart';
import 'package:flutter_teml/src/utils/keep_alive_wapper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/vertical_list_title.dart';

class WidgetListViewHPage extends StatelessWidget implements NameProvider {
  static const String _name = "ListView(H)";
  @override
  String get name => _name;

  final ScrollController _scrollController = ScrollController();

  WidgetListViewHPage({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    * GestureDetector(
      onPanUpdate: (details) {
        _scrollController.jumpTo(_scrollController.offset - details.delta.dx);
      },
      child:...)
    */
    // 控制左键水平滚动
    return Scaffold(
      body: HorizontalMouseScrollWrapper(
        controller: _scrollController,
        child: KeepAliveWrapper(
          //自定义的缓存组件
          child: Scrollbar(
            thumbVisibility: false,
            controller: _scrollController,
            // 静态列表
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              children: [
                SizedBox(
                  width: 120,
                  child: VerticalListTile(
                    leading: Icon(Icons.assessment, color: Colors.red),
                    title: Text("全部订单"),
                  ),
                ),

                const VerticalDivider(),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(
                    leading: Icon(Icons.payment, color: Colors.green),
                    title: Text("待付款"),
                  ),
                ),

                const VerticalDivider(),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(
                    leading: Icon(Icons.favorite, color: Colors.lightGreen),
                    title: Text("我的收藏"),
                  ),
                ),

                const VerticalDivider(),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(
                    leading: Image.asset("assets/images/avatar.jpg"),
                    title: const Text('华北黄淮高温雨今起强势登场 1'),
                    subtitle: const Text("中国天气网讯 21日开始，华北黄淮高温雨今起强势登场"),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(
                    leading: Image.asset("assets/images/avatar_male.jpg"),
                    title: const Text('华北黄淮高温雨今起强势登场 2'),
                    subtitle: const Text("中国天气网讯 21日开始，华北黄淮高温雨今起强势登场"),
                  ),
                ),

                Container(
                  color: Colors.black26,
                  width: 1, // Mock的Divider 作用，需要指定宽度
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表1")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表2")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表3")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表4")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表5")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表6")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表7")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表8")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表9")),
                ),
                SizedBox(
                  width: 120,
                  child: VerticalListTile(title: Text("我是关注列表10")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
