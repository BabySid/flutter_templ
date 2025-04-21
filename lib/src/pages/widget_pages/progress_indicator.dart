import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/keep_alive_wapper.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class WidgetProgressIndicatorPage extends StatefulWidget
    implements NameProvider {
  static const String _name = "ProgressIndicator";
  @override
  String get name => _name;

  const WidgetProgressIndicatorPage({super.key});
  @override
  State<WidgetProgressIndicatorPage> createState() =>
      _WidgetProgressIndicatorPageState();
}

class _WidgetProgressIndicatorPageState
    extends State<WidgetProgressIndicatorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    //动画执行时间3秒
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.repeat();
    _animationController.addListener(() => setState(() => {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeepAliveWrapper(
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 5, // 控制LinearProgressIndicator的线条粗细
              child: const LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Divider(),
            const LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
            Divider(),
            SizedBox(
              height: 100, // 控制CircularProgressIndicator的尺寸
              width: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: ColorTween(
                  begin: Colors.blue,
                  end: Colors.red,
                ).animate(_animationController),
                value: _animationController.value,
              ),
            ),
            Divider(),
            const CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
          ],
        ),
      ),
    );
  }
}
