import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/route_names.dart';
import 'package:flutter_teml/src/pages/function.dart';
import 'package:flutter_teml/src/pages/route_pages/target.dart';
import 'package:flutter_teml/src/pages/route_pages/target_2nd.dart';
import 'package:flutter_teml/src/pages/route_pages/target_3rd.dart';
import 'package:flutter_teml/src/pages/route_pages/target_hero.dart';
import 'package:flutter_teml/src/pages/routes.dart';
import 'package:flutter_teml/src/pages/home.dart';
import 'package:flutter_teml/src/pages/animation.dart';
import 'package:flutter_teml/src/pages/login.dart';
import 'package:flutter_teml/src/pages/page_view.dart';
import 'package:flutter_teml/src/pages/widgets.dart';

/*
配置ios风格的路由
1、删掉material.dart引入cupertino.dart
import 'package:flutter/cupertino.dart';
2、把 onGenerateRoute中的 MaterialPageRoute 替换成 CupertinoPageRoute
*/

final Map<String, WidgetBuilder> _routes = {
  loginPath: (context) => const LoginPage(),
  homePath: (context) => const MyHomePage(),
  functionalityPath: (context) => const FunctionalityPage(),
  widgetsPath: (context) => const WidgetsPage(),
  routesPath: (context) => const RoutePage(),
  pageViewPath: (context) => const PageViewPage(),
  animationPath: (context) => const AnimationPage(),
  targetRoutePage:
      (context, {arguments}) => TargetRoutePage(arguments: arguments ?? {}),
  targetRoute2rdPage: (context) => const TargetRoute2Page(),
  targetRoute3rdPage: (context) => const TargetRoute3Page(),
  targetHeroPage:
      (context, {arguments}) => TargetHeroPage(arguments: arguments ?? {}),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final String? name = settings.name; // routePath
  final Function? pageContBuilder =
      _routes[name]; // Function = (contxt) { return const NewsPage()}
  if (pageContBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder:
            (context) =>
                pageContBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) => pageContBuilder(context),
      );
      return route;
    }
  }
  return null;
}
