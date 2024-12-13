
import 'package:flutter/material.dart';
import 'package:flutter_praxtice/main.dart';
import 'package:flutter_praxtice/second_main.dart';
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