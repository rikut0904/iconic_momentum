import 'package:flutter/material.dart' show BuildContext, EdgeInsets, ListView, StatelessWidget, Widget;
import 'package:flutter_praxtice/main.dart';
import 'package:flutter_praxtice/second_body.dart';
import 'package:flutter_praxtice/second_main.dart';

class TodoListView extends StatelessWidget {
  final List<TodoItem> todoItems;
  final Function(int index, bool? value) onToggle;
  final Function(TodoItem item) onItemTap;

  const TodoListView({
    super.key,
    required this.todoItems,
    required this.onToggle,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: todoItems.length,
      itemBuilder: (context, index) {
        return TodoItemCard(
          item: todoItems[index],
          onToggle: (value) => onToggle(index, value),
          onTap: () => onItemTap(todoItems[index]),
        );
      },
    );
  }
}
