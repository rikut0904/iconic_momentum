import 'package:flutter/material.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/Other.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.item});
  final TodoItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('項目の詳細'),
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
        child: Text(
          item.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
