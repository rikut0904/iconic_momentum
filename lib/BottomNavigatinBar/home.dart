import 'package:flutter/material.dart';

typedef TodoItem = ({String title, bool done});

class Homeroute extends StatelessWidget {
  const Homeroute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 背景を白に設定
      appBar: AppBar(
        title: const Text('iconic momentum'),
        backgroundColor: Colors.purple[300], // AppBarの色
      ),
      body: const Center(
        child: Text(
          'ToDoリスト',
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}
