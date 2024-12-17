import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TodoItem {
  final String title;
  final String content;
  final String schedule;
  bool done;

  TodoItem({
    required this.title,
    required this.content,
    required this.schedule,
    this.done = false,
  });
}

class CompletedToDoPage extends StatefulWidget {
  const CompletedToDoPage({super.key, required this.completeToDo});

  final List<TodoItem> completeToDo;

  @override
  _CompletedToDoState createState() => _CompletedToDoState();
}

class _CompletedToDoState extends State<CompletedToDoPage> {
  final List<TodoItem> todoItems = [];

  void _addNewTask(BuildContext context) {
    final TextEditingController todoName = TextEditingController();
    final TextEditingController todoContent = TextEditingController();
    final TextEditingController todoSchedule = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'ToDoリスト追加',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ToDo名(必須):',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextField(
              controller: todoName,
              decoration: const InputDecoration(hintText: 'タスク名を入力'),
            ),
            const SizedBox(height: 30),
            const Text(
              '内容(必須):',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextField(
              controller: todoContent,
              decoration: const InputDecoration(hintText: '内容を入力'),
            ),
            const SizedBox(height: 30),
            const Text(
              '期限(任意):',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: todoSchedule,
                  decoration: const InputDecoration(hintText: '日付を選択'),
                  readOnly: true,
                ),
              ),
              IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () async {
                  final DateTime? selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2034),
                  );
                  if (selected != null) {
                    todoSchedule.text =
                        "\'" + (DateFormat('yy/MM/dd')).format(selected);
                  }
                },
              )
            ])
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'キャンセル',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              final taskName = todoName.text.trim();
              final taskContent = todoContent.text.trim();
              final taskSchedule = todoSchedule.text.trim();

              if (taskName.isEmpty || taskContent.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('エラー'),
                    content: const Text('ToDo名又は内容が不明です'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              }
              setState(() {
                todoItems.add(
                  TodoItem(
                    title: taskName,
                    content: taskContent,
                    schedule: taskSchedule,
                  ),
                );
              });
              Navigator.of(context).pop();
            },
            child: const Text(
              '追加',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///タスクをやったことリストへ移動する処理
  ///issue#7で変更
  void _moveTask(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iconic Momentum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[300], // AppBarの色
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'ToDoリスト',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: todoItems.isEmpty
                ? const Center(
                    child: Text(
                      'タスクはまだありません',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: todoItems.length,
                    itemBuilder: (context, index) {
                      final item = todoItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(Icons.circle_rounded,
                              color: Colors.grey, size: 30),
                          title: Text(
                              '${item.title}${item.schedule.isNotEmpty ? " | " + item.schedule : ""}'),
                          subtitle: Text(item.content),
                          trailing: Checkbox(
                            value: item.done,
                            onChanged: (value) {
                              if (value == true) {
                                _moveTask(index);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewTask(context),
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
