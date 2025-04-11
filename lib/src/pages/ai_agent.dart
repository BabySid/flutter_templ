import 'package:flutter/material.dart';

class AIAgentPage extends StatefulWidget {
  const AIAgentPage({super.key});

  @override
  State<AIAgentPage> createState() => _AIAgentPageState();
}

class _AIAgentPageState extends State<AIAgentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI-Agent页面")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("AI-AgentPage")],
        ),
      ),
    );
  }
}
