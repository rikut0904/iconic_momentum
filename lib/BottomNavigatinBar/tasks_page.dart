import 'package:flutter/material.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_menu.dart';
import 'package:intl/intl.dart';

class TodidItem {
  final String title;
  final String content;
  final String schedule;
  final String group;
  bool done;

  TodidItem({
    required this.title,
    required this.content,
    required this.schedule,
    required this.group,
    this.done = false,
  });
}

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key, required List completedTasks});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  final List<TodidItem> todidItems = [];

  /// 新しいタスクを追加する処理
  void _addNewTask(BuildContext context) {
    final TextEditingController todidName = TextEditingController();
    final TextEditingController todidContent = TextEditingController();
    final TextEditingController todidSchedule = TextEditingController();
    final TextEditingController todidGroup = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'やったこと追加',
          style: TextStyle(fontSize: 28),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'やったこと名(必須):',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextField(
              controller: todidName,
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
              controller: todidContent,
              decoration: const InputDecoration(hintText: '内容を入力'),
            ),
            const SizedBox(height: 30),
            const Text(
              '日程(任意):',
              style: TextStyle(fontSize: 15),
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: todidSchedule,
                  decoration: const InputDecoration(hintText: '日時を入力'),
                  readOnly: true,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () async {
                  final DateTime? selected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2034),
                  );
                  if (selected != null) {
                    todidSchedule.text =
                        "'${(DateFormat('yy/MM/dd')).format(selected)}";
                  }
                },
              )
            ]),
            const SizedBox(height: 10),
            const Text(
              'グループ選択：',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const DropdownMenuExample(),
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
              final taskName = todidName.text.trim();
              final taskContent = todidContent.text.trim();
              final taskSchedule = todidSchedule.text.trim();
              final taskGroup = todidGroup.text.trim();

              if (taskName.isEmpty || taskContent.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('エラー'),
                    content: const Text('やったこと名又は内容が不明です'),
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
                todidItems.add(
                  TodidItem(
                    title: taskName,
                    content: taskContent,
                    schedule: taskSchedule,
                    group: taskGroup,
                    done: false,
                  ),
                );
              });
              Navigator.of(context).pop();
            },
            child: const Text(
              '追加',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// タスクを削除する処理
  void _removeTask(int index) {
    setState(() {
      todidItems.removeAt(index);
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
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'やったことリスト',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const DropdownMenuExample(),
            const SizedBox(height: 16),
            Expanded(
              child: todidItems.isEmpty
                  ? const Center(
                      child: Text(
                        'タスクはまだありません',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: todidItems.length,
                      itemBuilder: (context, index) {
                        final item = todidItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: const Icon(Icons.circle_rounded,
                                color: Colors.grey, size: 30),
                            title: Text(
                                '${item.title}${item.schedule.isNotEmpty ? " | ${item.schedule}" : ""}'),
                            subtitle: Text(item.content),
                            trailing: Checkbox(
                              value: item.done,
                              onChanged: (value) {
                                if (value == true) {
                                  _removeTask(index);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewTask(context),
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
