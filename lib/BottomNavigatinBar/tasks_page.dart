import 'package:flutter/material.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_menu.dart';

typedef TodoItem = ({String title, String content, String schedule, bool done});

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key, required List completedTasks});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  final List<TodoItem> todidItems = [];

  /// 新しいタスクを追加する処理
  void _addNewTask(BuildContext context) {
    final TextEditingController todoName = TextEditingController();
    final TextEditingController todoContent = TextEditingController();
    final TextEditingController todoSchedule = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'やったことリスト',
          style: TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('やったこと追加', style: TextStyle(fontSize: 13)),
              const SizedBox(height: 10),
              const Text('やったこと名：', style: TextStyle(fontSize: 13)),
              TextField(
                controller: todoName,
                decoration: const InputDecoration(hintText: 'タスク名を入力'),
              ),
              const SizedBox(height: 10),
              const Text('内容：', style: TextStyle(fontSize: 13)),
              TextField(
                controller: todoContent,
                decoration: const InputDecoration(hintText: '内容を入力'),
              ),
              const SizedBox(height: 10),
              const Text('日程(任意)：', style: TextStyle(fontSize: 13)),
              TextField(
                controller: todoSchedule,
                decoration: const InputDecoration(hintText: '日時を入力'),
              ),
              const SizedBox(height: 10),
              const Text('グループ選択：', style: TextStyle(fontSize: 13)),
              const DropdownMenuExample(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              final taskName = todoName.text.trim();
              final taskContent = todoContent.text.trim();
              final taskSchedule = todoSchedule.text.trim();

              if (taskName.isNotEmpty) {
                setState(() {
                  todidItems.add((
                    title: taskName,
                    content: taskContent,
                    schedule: taskSchedule,
                    done: false,
                  ));
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('追加', style: TextStyle(color: Colors.blue)),
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
                            title: Text(item.title),
                            subtitle:
                                Text('${item.content} - ${item.schedule}'),
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
