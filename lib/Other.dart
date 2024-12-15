import 'package:flutter/material.dart';
import 'package:iconic_momentum/GroupButton.dart';
import 'package:iconic_momentum/CheckBox.dart';
import 'package:iconic_momentum/ListAddButton.dart';

typedef TodoItem = ({String title, bool done});

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<TodoItem> todoItems = [
    (title: 'Accentureセッションに参加', done: false),
    (title: 'モバイル開発について学習する', done: false),
    (title: '実際にアプリを作ってみる', done: false),
    (title: 'タスク管理アプリを作る！', done: false)
  ];

  void _toggleTodoItem(int index, bool? value) {
    if (value != null) {
      setState(() {
        todoItems[index] = (title: todoItems[index].title, done: value);
      });
    }
  }

  void _goToDetailPage(TodoItem item) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => DetailPage(item: item)),
    );
  }

  void _addNewItem() {
    setState(() {
      todoItems.add((title: "新しい項目", done: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'iconic momentum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'やったことリスト',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const DropdownMenuExample(),
            const SizedBox(height: 20),
            Expanded(
              child: TodoListView(
                todoItems: todoItems,
                onToggle: _toggleTodoItem,
                onItemTap: _goToDetailPage,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: Colors.purple[300],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        selectedItemColor: Colors.purple[300],
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }
}
