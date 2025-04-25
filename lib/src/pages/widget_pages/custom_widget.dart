import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:flutter_teml/src/widgets/custom_check_box.dart';
import 'package:flutter_teml/src/widgets/done_widget.dart';
import 'package:flutter_teml/src/widgets/gradient_button.dart';
import 'package:flutter_teml/src/widgets/gradient_circular_progress_indicator.dart';
import 'package:flutter_teml/src/widgets/turn_box.dart';

class CustomWidgetPage extends StatefulWidget implements NameProvider {
  static const String _name = "CustomWidget";
  @override
  String get name => _name;

  const CustomWidgetPage({super.key});

  @override
  State<CustomWidgetPage> createState() => _CustomWidgetPageState();
}

class _CustomWidgetPageState extends State<CustomWidgetPage>
    with TickerProviderStateMixin {
  double _turns = .0;
  late AnimationController _animationController;
  bool _checked = false;

  bool _show = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: _show,
                child: Row(
                  children: const [DoneWidget(), DoneWidget(outline: true)],
                ),
              ), //默认可见

              IconButton(
                icon: const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _show = !_show;
                  });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCheckbox(value: _checked, onChanged: _onChange),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CustomCheckbox(
                    strokeWidth: 1,
                    radius: 1,
                    value: _checked,
                    onChanged: _onChange,
                  ),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: CustomCheckbox(
                  strokeWidth: 3,
                  radius: 3,
                  value: _checked,
                  onChanged: _onChange,
                ),
              ),
            ],
          ),
          Divider(),
          TurnBox(
            turns: _turns,
            speed: 500,
            child: const Icon(Icons.refresh, size: 50),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: const Icon(Icons.refresh, size: 150.0),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GradientButton(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                colors: [Colors.lightBlue.shade300, Colors.black],
                splashColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _turns += 0.25;
                  });
                },
                child: const Text("顺时针旋转"),
              ),
              ElevatedGradientButton(
                colors: [Colors.red, Colors.orange],
                onPressed: () {
                  setState(() {
                    _turns -= 0.25;
                  });
                },
                padding: const EdgeInsets.all(10),
                splashColor: Colors.brown,
                borderRadius: BorderRadius.circular(20),
                textColor: Colors.white,
                child: const Text("逆时针旋转"),
              ),
            ],
          ),
          Divider(),
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 16.0,
                      children: [
                        GradientCircularProgressIndicator(
                          // No gradient
                          colors: const [Colors.blue, Colors.blue],
                          radius: 50.0,
                          stokeWidth: 3.0,
                          value: _animationController.value,
                        ),
                        GradientCircularProgressIndicator(
                          colors: const [Colors.red, Colors.orange],
                          radius: 50.0,
                          stokeWidth: 3.0,
                          value: _animationController.value,
                        ),
                        GradientCircularProgressIndicator(
                          colors: const [Colors.red, Colors.orange, Colors.red],
                          radius: 50.0,
                          stokeWidth: 5.0,
                          value: _animationController.value,
                        ),
                        GradientCircularProgressIndicator(
                          colors: const [Colors.teal, Colors.cyan],
                          radius: 50.0,
                          stokeWidth: 5.0,
                          strokeCapRound: true,
                          value:
                              CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.decelerate,
                              ).value,
                        ),
                        TurnBox(
                          turns: 1 / 8,
                          child: GradientCircularProgressIndicator(
                            colors: const [
                              Colors.red,
                              Colors.orange,
                              Colors.red,
                            ],
                            radius: 50.0,
                            stokeWidth: 5.0,
                            strokeCapRound: true,
                            backgroundColor: Colors.red.shade50,
                            totalAngle: 1.5 * pi,
                            value:
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: Curves.ease,
                                ).value,
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: GradientCircularProgressIndicator(
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade200,
                            ],
                            radius: 50.0,
                            stokeWidth: 3.0,
                            strokeCapRound: true,
                            backgroundColor: Colors.transparent,
                            value: _animationController.value,
                          ),
                        ),
                        GradientCircularProgressIndicator(
                          colors: [
                            Colors.red,
                            Colors.amber,
                            Colors.cyan,
                            Colors.green.shade200,
                            Colors.blue,
                            Colors.red,
                          ],
                          radius: 50.0,
                          stokeWidth: 5.0,
                          strokeCapRound: true,
                          value: _animationController.value,
                        ),
                      ],
                    ),
                    Divider(),
                    GradientCircularProgressIndicator(
                      colors: [Colors.blue.shade700, Colors.blue.shade200],
                      radius: 100.0,
                      stokeWidth: 20.0,
                      value: _animationController.value,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GradientCircularProgressIndicator(
                        colors: [Colors.blue.shade700, Colors.blue.shade300],
                        radius: 100.0,
                        stokeWidth: 20.0,
                        value: _animationController.value,
                        strokeCapRound: true,
                      ),
                    ),
                    Divider(),
                    //剪裁半圆
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: .5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            //width: 100.0,
                            child: TurnBox(
                              turns: .75,
                              child: GradientCircularProgressIndicator(
                                colors: [Colors.teal, Colors.cyan.shade500],
                                radius: 100.0,
                                stokeWidth: 8.0,
                                value: _animationController.value,
                                totalAngle: pi,
                                strokeCapRound: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 104.0,
                      width: 200.0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            height: 200.0,
                            top: .0,
                            child: TurnBox(
                              turns: .75,
                              child: GradientCircularProgressIndicator(
                                colors: [Colors.teal, Colors.cyan.shade500],
                                radius: 100.0,
                                stokeWidth: 8.0,
                                value: _animationController.value,
                                totalAngle: pi,
                                strokeCapRound: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "${(_animationController.value * 100).toInt()}%",
                              style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }

  void _onChange(value) {
    setState(() => _checked = value);
  }
}
