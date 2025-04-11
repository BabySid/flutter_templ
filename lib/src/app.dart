import 'package:flutter/material.dart';
import 'package:flutter_teml/src/constants/helper.dart';
import 'package:flutter_teml/src/constants/route_names.dart';
import 'package:flutter_teml/src/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'), // 如果使用了路由，则不必设置home
      initialRoute: homePath,
      onGenerateRoute: onGenerateRoute,
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
    );
  }
}
