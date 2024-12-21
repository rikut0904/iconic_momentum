import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Firestoreからデータを読み込む
  factory TodoItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoItem(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      schedule: data['schedule'] ?? '',
      done: data['done'] ?? false,
    );
  }

  // Firestoreにデータを保存する形式に変換
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'schedule': schedule,
      'done': done,
    };
  }
}

class CompletedToDoPage extends StatefulWidget {
  const CompletedToDoPage({super.key, required List completeToDo});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CompletedToDoPage> {
  int _currentIndex = 0;

  // タスクリスト
  List<TodoItem> todoItems = [];
  List<TodoItem> completedItems = [];

  // Firestoreコレクション参照
  final CollectionReference _todoCollection =
      FirebaseFirestore.instance.collection('todo');

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Firestoreからタスクをロード
  void _loadTasks() async {
    final todosSnapshot =
        await _todoCollection.where('done', isEqualTo: false).get();
    final completedSnapshot =
        await _todoCollection.where('done', isEqualTo: true).get();

    setState(() {
      todoItems =
          todosSnapshot.docs.map((doc) => TodoItem.fromFirestore(doc)).toList();
      completedItems = completedSnapshot.docs
          .map((doc) => TodoItem.fromFirestore(doc))
          .toList();
    });
  }

  // Firestoreに新しいタスクを追加
  Future<void> _addTaskToFirestore(
      String title, String content, String schedule) async {
    await _todoCollection.add({
      'title': title,
      'content': content,
      'schedule': schedule,
      'done': false,
    });
    _loadTasks();
  }

  // Firestoreでタスクの状態を更新
  Future<void> _updateTaskDone(String title, bool done) async {
    final snapshot =
        await _todoCollection.where('title', isEqualTo: title).get();
    for (var doc in snapshot.docs) {
      await doc.reference.update({'done': done});
    }
    _loadTasks();
  }

  // Firestoreでタスクを削除
  Future<void> _deleteTask(String title) async {
    final snapshot =
        await _todoCollection.where('title', isEqualTo: title).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    _loadTasks(); // ローカルデータを再読み込み
  }

  // チェックボックスを押した際の処理
  void _onCheckboxChanged(TodoItem item, bool? value) async {
    if (value == true) {
      // タスクを「完了済み」にする
      await _updateTaskDone(item.title, true);
      await _deleteTask(item.title); // Firestoreから削除
    } else {
      print('チェックが解除されました');
    }
  }

  // 新しいタスクを追加する関数
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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ToDo名(必須):'),
              TextField(
                controller: todoName,
                decoration: const InputDecoration(hintText: 'タスク名を入力'),
              ),
              const SizedBox(height: 16),
              const Text('内容(必須):'),
              TextField(
                controller: todoContent,
                decoration: const InputDecoration(hintText: '内容を入力'),
              ),
              const SizedBox(height: 16),
              const Text('期限(任意):'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoSchedule,
                      decoration: const InputDecoration(hintText: '日付を選択'),
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
                        todoSchedule.text =
                            DateFormat('yyyy/MM/dd').format(selected);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'キャンセル',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              final taskName = todoName.text.trim();
              final taskContent = todoContent.text.trim();
              final taskSchedule = todoSchedule.text.trim();

              if (taskName.isEmpty || taskContent.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('エラー'),
                    content: const Text('ToDo名または内容を入力してください。'),
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

              await _addTaskToFirestore(taskName, taskContent, taskSchedule);
              Navigator.of(context).pop();
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentList = _currentIndex == 0 ? todoItems : completedItems;

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
            Text(
              _currentIndex == 0 ? 'ToDoリスト' : '完了済みタスク',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: currentList.isEmpty
                  ? Center(
                      child: Text(
                        _currentIndex == 0 ? 'タスクはまだありません' : '完了済みタスクはまだありません',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        final item = currentList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(
                              item.done
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: item.done ? Colors.green : Colors.grey,
                            ),
                            title: Text(
                              '${item.title}${item.schedule.isNotEmpty ? " | ${item.schedule}" : ""}',
                            ),
                            subtitle: Text(item.content),
                            trailing: _currentIndex == 0
                                ? Checkbox(
                                    value: item.done,
                                    onChanged: (value) {
                                      _onCheckboxChanged(
                                          item, value); // チェックボックス押下時の処理
                                    },
                                  )
                                : null,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: '完了済み',
          ),
        ],
      ),
    );
  }
}
