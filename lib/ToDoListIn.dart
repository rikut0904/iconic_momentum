import 'package:flutter/material.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/Other.dart';

class TodoItemCard extends StatelessWidget {
  final TodoItem item;
  final Function(bool? value) onToggle;
  final VoidCallback onTap;

  const TodoItemCard({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple[300],
          child: const Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "タップして詳細を見る",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Checkbox(
          value: item.done,
          onChanged: onToggle,
          activeColor: Colors.purple[400],
        ),
        onTap: onTap,
      ),
    );
  }
}
