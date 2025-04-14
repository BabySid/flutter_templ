import 'package:flutter/material.dart';
import 'package:flutter_teml/src/pages/ai_agent.dart';
import 'package:flutter_teml/src/pages/widgets.dart';
import 'package:flutter_teml/src/pages/routes.dart';
import 'package:flutter_teml/src/pages/animation.dart';
import 'package:flutter_teml/src/pages/page_view.dart';

class MyHomePage extends StatefulWidget {
  final int tabIndex;
  const MyHomePage({
    super.key,
    this.title = 'Flutter Demo Home Page',
    this.tabIndex = 0,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    WidgetsPage(),
    RoutePage(),
    AIAgentPage(),
    AnimationPage(),
    PageViewPage(),
  ];

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      endDrawer: buildEndDrawer(),
      body: _pages[_currentIndex], // 主页面内容
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButton: buildFloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
      // 左侧drawer图标
      leading: Builder(
        builder:
            (BuildContext context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: '工具集合',
            ),
      ),
      // 右侧drawer图标以及其他action集合
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
          tooltip: "搜索",
        ),
        Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.person_pin_circle),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: "用户信息",
              ),
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
      fixedColor: Colors.red, //选中的颜色
      //selectedItemColor: Colors.amber[800],
      //iconSize: 35, //底部菜单大小
      currentIndex: _currentIndex, //第几个菜单选中
      type: BottomNavigationBarType.fixed, //如果底部有4个或者4个以上的菜单的时候就需要配置这个参数
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.widgets), label: "Widget"),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: "Route"),
        BottomNavigationBarItem(
          icon: Icon(Icons.support_agent),
          label: "AI-Agent",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Animation"),
        BottomNavigationBarItem(icon: Icon(Icons.pageview), label: "PageView"),
      ],
    );
  }

  BottomAppBar buildBottomNavBarUseBottomAppBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.widgets),
            onPressed: () => {},
            label: Text("Widget"),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.category),
            onPressed: () => {},
            label: Text("Route"),
          ),
          SizedBox(), //中间位置空出
          ElevatedButton.icon(
            icon: Icon(Icons.list),
            onPressed: () => {},
            label: Text("Animation"),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.business),
            onPressed: () => {},
            label: Text("PageView"),
          ),
        ], //均分底部导航栏横向空间
      ),
    );
  }

  Widget buildFloatingActionBtn() {
    return Container(
      height: 60, //调整FloatingActionButton的大小
      width: 60,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5), //调整FloatingActionButton的位置
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: FloatingActionButton(
        backgroundColor: _currentIndex == 2 ? Colors.red : Colors.blue,
        shape: CircleBorder(),
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildDrawer() {
    return const NavigationDrawer(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  // color: Colors.yellow,
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/avatar_male.jpg",
                        ),
                      ),
                      title: Text("张三", style: TextStyle(color: Colors.red)),
                    ),
                    ListTile(title: Text("邮箱：zhangsan@qq.com")),
                  ],
                ),
              ),
            ),
          ],
        ),
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.sunny)),
          title: Text("天气预报"),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.calculate)),
          title: Text("计算器"),
        ),
        Divider(),
        Divider(),
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.newspaper)),
          title: Text("热门新闻"),
        ),
      ],
    );
  }

  Widget buildEndDrawer() {
    return NavigationDrawer(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: UserAccountsDrawerHeader(
                accountName: const Text("张三"),
                accountEmail: const Text("lisi@qq.com"),
                otherAccountsPictures: [
                  Image.asset("assets/images/avatar_female.jpg"),
                ],
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar_male.jpg"),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/bg2.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
        const ListTile(
          leading: CircleAvatar(child: Icon(Icons.people)),
          title: Text("个人中心"),
        ),
        const Divider(),
        const ListTile(
          leading: CircleAvatar(child: Icon(Icons.settings)),
          title: Text("系统设置"),
        ),
        const Divider(),
      ],
    );
  }
}
