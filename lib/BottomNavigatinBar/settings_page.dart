import 'package:flutter/material.dart';

typedef TodoItem = ({String title, bool done});

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('設定画面', style: TextStyle(fontSize: 24)),
    );
  }
}
