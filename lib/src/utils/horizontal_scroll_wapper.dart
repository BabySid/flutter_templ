import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HorizontalMouseScrollWrapper extends StatefulWidget {
  final Widget child;
  final ScrollController? controller;
  final Duration scrollDuration;
  final Curve scrollCurve;

  const HorizontalMouseScrollWrapper({
    super.key,
    required this.child,
    this.controller,
    this.scrollDuration = const Duration(milliseconds: 100),
    this.scrollCurve = Curves.easeOutQuart,
  });

  @override
  State<HorizontalMouseScrollWrapper> createState() =>
      _HorizontalMouseScrollWrapperState();
}

class _HorizontalMouseScrollWrapperState
    extends State<HorizontalMouseScrollWrapper> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _handleMouseScroll(PointerScrollEvent event) {
    if (_scrollController.hasClients) {
      final double scrollDelta = event.scrollDelta.dy;
      _scrollController.position.moveTo(
        _scrollController.offset + scrollDelta,
        curve: widget.scrollCurve,
        duration: widget.scrollDuration,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          _handleMouseScroll(pointerSignal);
        }
      },
      child: widget.child,
    );
  }
}
