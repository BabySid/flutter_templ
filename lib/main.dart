import 'package:flutter/material.dart';
import 'package:flutter_teml/src/app.dart';
import 'package:flutter_teml/src/constants/global.dart';

void main() {
  Global.init().then((_) => runApp(const MyApp()));
}
