import 'package:flutter/material.dart';
import 'package:flutter_teml/generated/l10n.dart';
import 'package:flutter_teml/src/utils/name_provider.dart';
import 'package:intl/intl.dart';

class L10nPage extends StatefulWidget implements NameProvider {
  static const String _name = "L10n";
  @override
  String get name => _name;

  const L10nPage({super.key});

  @override
  State<L10nPage> createState() => _L10nPageState();
}

class _L10nPageState extends State<L10nPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (Intl.getCurrentLocale() == "en") {
                    return;
                  }
                  setState(() {
                    S.load(Locale.fromSubtags(languageCode: 'en'));
                  });
                },
                child: const Text("En"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Intl.getCurrentLocale() == "zh_CN") {
                    return;
                  }
                  setState(() {
                    S.load(
                      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
                    );
                  });
                },
                child: const Text("Cn"),
              ),
            ],
          ),
          Divider(),
          Text("Current Locale: ${Intl.getCurrentLocale()}"),
          Text("Value1: ${S.current.value1}"),
          Text("Value2: ${S.current.value2}"),
          Text("Value3: ${S.current.value3("1", "2")}"),
          Text("Value4: ${S.current.value4(DateTime.now())}"),
        ],
      ),
    );
  }
}
