import 'package:flutter/material.dart';

// 削除済みタスクを表示するクラス
class CompletedTasksPage extends StatelessWidget {
  final List<String> deletedTasks;

  const CompletedTasksPage({super.key, required this.deletedTasks}); // コンストラクタでデータを受け取る

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("削除済みタスク")),
      body: ListView.builder(
        itemCount: deletedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(deletedTasks[index]), // 削除済みタスクを表示
          );
        },
      ),
    );
  }
}
