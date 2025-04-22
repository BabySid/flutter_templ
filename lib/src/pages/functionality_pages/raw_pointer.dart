import 'package:flutter/material.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';

class RawPointerPage extends StatefulWidget implements NameProvider {
  static const String _name = "RawPointer";
  @override
  String get name => _name;

  const RawPointerPage({super.key});

  @override
  State<RawPointerPage> createState() => _RawPointerPageState();
}

class _RawPointerPageState extends State<RawPointerPage> {
  PointerEvent? _event;
  PointerEvent? _event2;
  PointerEvent? _event3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Listener"),
            Listener(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 500.0,
                height: 450.0,
                child: Text(
                  'localPosition: ${_event?.localPosition ?? ''}'
                  '\n'
                  'position: ${_event?.position ?? ''}'
                  '\n'
                  'delta: ${_event?.delta ?? ''}'
                  '\n'
                  'orientation: ${_event?.orientation ?? ''}'
                  '\n'
                  'pressure: ${_event?.pressure ?? ''}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPointerDown:
                  (PointerDownEvent event) => setState(() => _event = event),
              onPointerMove:
                  (PointerMoveEvent event) => setState(() => _event = event),
              onPointerUp:
                  (PointerUpEvent event) => setState(() => _event = event),
            ),
            Divider(),
            const Text("AbsorbPointer"), // IgnorePointer
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.lightBlue,
                    width: 500.0,
                    height: 200.0,
                    child: Text(
                      "AbsorbPointer's Child: ${_event2?.localPosition ?? ''}"
                      '\n'
                      'AbsorbPointerSelf: ${_event3?.localPosition ?? ''}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPointerDown: (event) => setState(() => _event2 = event),
                ),
              ),
              onPointerDown: (event) => setState(() => _event3 = event),
            ),
          ],
        ),
      ),
    );
  }
}
