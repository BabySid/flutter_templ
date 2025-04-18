import 'package:flutter/material.dart';

class Spacer extends StatelessWidget {
  const Spacer({super.key, this.flex = 1}) : assert(flex > 0);

  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: const SizedBox.shrink());
  }
}
