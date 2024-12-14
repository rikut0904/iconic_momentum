import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:iconic_momentum/GroupButton.dart';
import 'package:iconic_momentum/CheckBox.dart';
import 'package:iconic_momentum/Other.dart';
import 'package:iconic_momentum/ListAddButton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iconic momentum',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 110, 58, 120),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const TodoPage(),
    );
  }
}





// class _TodoListPageState extends State<TodoListPage> {
//   // Todoリストのデータ
//   List<String> todoList = [];
//   //削除する作業
//   void _deleteTodoItem(int index) {
//     setState(() {
//       todoList.removeAt(index);
//     });
//   }
// }
