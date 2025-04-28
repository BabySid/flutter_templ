import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_teml/generated/l10n.dart';
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
      onGenerateTitle: (context) => 'Flutter Template',
      //title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.lightBlue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'), // 如果使用了路由，则不必设置home
      initialRoute: homePath,
      onGenerateRoute: onGenerateRoute,
      // 为了使用 FToast 需要设置 navigatorKey
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
      // 支持i18n
      localizationsDelegates: [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          (locale, supportedLocales) => Locale('zh', 'CN'),
      // localeListResolutionCallback: (locales, supportedLocales) {
      //   //print("$locales, $supportedLocales");
      //   return Locale('cn', 'CN');
      // },
    );
  }
}
