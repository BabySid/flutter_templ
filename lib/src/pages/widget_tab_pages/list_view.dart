import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/keep_alive_wapper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetListViewPage extends StatefulWidget implements NameProvider {
  static const String _name = "ListView(V)";

  @override
  String get name => _name;

  const WidgetListViewPage({super.key});

  @override
  State<WidgetListViewPage> createState() => _WidgetListViewPageState();
}

class _WidgetListViewPageState extends State<WidgetListViewPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _lastItemKey = GlobalKey();

  late AnimationController _animationController;
  double _lastMaxScrollExtent = 0;

  List<Widget> _listItems = [];
  final List<String> _newItems = [];

  void _initListItems() {
    // 这些数据可以从配置文件等读取并初始化
    _listItems = [
      Container(
        height: 44,
        padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: const Text("图标列表", textAlign: TextAlign.left),
      ),
      ListTile(
        leading: Icon(Icons.assessment, color: Colors.red),
        title: Text("全部订单"),
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.payment, color: Colors.green),
        title: Text("待付款"),
      ),
      const Divider(),
      ListTile(
        leading: Icon(Icons.favorite, color: Colors.lightGreen),
        title: Text("我的收藏"),
      ),
      const Divider(),
      Container(
        height: 44,
        padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: const Text("图文列表", textAlign: TextAlign.start),
      ),
      ListTile(
        leading: Image.asset("assets/images/avatar.jpg"),
        title: const Text('华北黄淮高温雨今起强势登场 1'),
        subtitle: const Text("中国天气网讯 21日开始，华北黄淮高温雨今起强势登场"),
        trailing: Image.asset("assets/images/img.jpg"),
      ),
      ListTile(
        leading: Image.asset("assets/images/avatar_male.jpg"),
        title: const Text('华北黄淮高温雨今起强势登场 2'),
        subtitle: const Text("中国天气网讯 21日开始，华北黄淮高温雨今起强势登场"),
        trailing: Image.asset("assets/images/avatar_female.jpg"),
      ),
      const Divider(),
      SizedBox(height: 10),
      Container(
        height: 44,
        padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: const Text("普通列表"),
      ),
      ListTile(title: Text("我是关注列表1")),
      ListTile(title: Text("我是关注列表2")),
      ListTile(title: Text("我是关注列表3")),
      ListTile(title: Text("我是关注列表4")),
      ListTile(title: Text("我是关注列表5")),
      ListTile(title: Text("我是关注列表6")),
      ListTile(title: Text("我是关注列表7")),
      ListTile(title: Text("我是关注列表8")),
      ListTile(title: Text("我是关注列表9")),
      ListTile(title: Text("我是关注列表10")),
      ListTile(title: Text("我是关注列表11")),
      ListTile(title: Text("我是关注列表12")),
      ListTile(title: Text("我是关注列表13")),
      ListTile(title: Text("我是关注列表14")),
      ListTile(title: Text("我是关注列表15")),
      ListTile(title: Text("我是关注列表16")),
      ListTile(title: Text("我是关注列表17")),
      ListTile(title: Text("我是关注列表18")),
      ListTile(title: Text("我是关注列表19")),
      ListTile(title: Text("我是关注列表20")),
      ListTile(title: Text("我是关注列表21")),
      ListTile(title: Text("我是关注列表22")),
      ListTile(title: Text("我是关注列表23")),
      ListTile(title: Text("我是关注列表24")),
      ListTile(title: Text("我是关注列表25")),
      ListTile(title: Text("我是关注列表26")),
      ListTile(title: Text("我是关注列表27")),
      ListTile(title: Text("我是关注列表28")),
      ListTile(title: Text("我是关注列表29")),
      ListTile(title: Text("我是关注列表30")),
    ];
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _initListItems();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _scrollController.dispose();
  }

  void _addItemAndScroll() {
    setState(() {
      _newItems.add("我是新的关注列表:${_newItems.length}"); // 添加新项
    });
    // 在布局完成后触发滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  // 递归滚动到底部
  void _startProgressiveScroll() {
    _lastMaxScrollExtent = _scrollController.position.maxScrollExtent;
    // 开始滚动动画
    _animationController.forward(from: .5).then((_) {
      // 动画结束后检查是否需要继续滚动
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.position.maxScrollExtent > _lastMaxScrollExtent) {
          _startProgressiveScroll(); // 递归触发下一阶段滚动
        }
      });
    });

    // 创建滚动动画
    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    animation.addListener(() {
      final targetOffset = _lastMaxScrollExtent * animation.value;
      _scrollController.jumpTo(targetOffset);
    });
  }

  // 滚动到底部的方法
  void _scrollToBottom() {
    // // 直接定位到最后一个元素. 前提是最后一个元素得渲染出来，而flutter是惰性的，即未显示则不会渲染
    // // 所以得让最后一个元素显示出来。
    // if (_lastItemKey.currentContext != null) {
    //   Scrollable.ensureVisible(
    //     _lastItemKey.currentContext!,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeOut,
    //     alignment: 1.0,
    //   );
    // }

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // 滚动到最大位置
      duration: Duration(milliseconds: 300), // 动画时长
      curve: Curves.easeOut, // 动画曲线
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: KeepAliveWrapper(
        //动态列表
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 40),
              itemCount: _listItems.length + _newItems.length,
              itemBuilder: (BuildContext context, int index) {
                if (index <= _listItems.length - 1) {
                  return _listItems[index];
                }

                if (index <= _listItems.length + _newItems.length - 2) {
                  return ListTile(
                    title: Text(_newItems[index - _listItems.length]),
                  );
                }

                return ListTile(
                  key: _lastItemKey,
                  title: Text(_newItems[_newItems.length - 1]),
                );
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              height: 40,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addItemAndScroll,
                    child: const Text("添加列表内容", textAlign: TextAlign.center),
                  ),
                  ElevatedButton(
                    onPressed: _startProgressiveScroll,
                    child: const Text("跳转到最下", textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
