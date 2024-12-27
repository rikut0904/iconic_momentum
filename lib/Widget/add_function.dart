import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/Widget/load_del_function.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 新しいタスクを追加する関数
Future<void> addNewTask(
    BuildContext context, WidgetRef ref, todoCollection) async {
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
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2040),
                    );
                    if (selected != null) {
                      todoSchedule.text =
                          DateFormat('yyyy-MM-dd').format(selected);
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
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
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
            final place = ref.watch(dropdownValueProvider);
            final username = ref.watch(infoName);
            await addTaskToFirestore(taskName, taskContent, taskSchedule,
                username, place, context, ref, todoCollection);
            // ignore: use_build_context_synchronously
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('追加'),
        ),
      ],
    ),
  );
}

// Firestoreに新しいタスクを追加
Future<void> addTaskToFirestore(
    String title,
    String content,
    String schedule,
    String username,
    String place,
    BuildContext context,
    WidgetRef ref,
    CollectionReference todoCollection) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("ユーザーがログインしていません");
  }
  try {
    await todoCollection.add({
      'title': title,
      'content': content,
      'schedule': schedule,
      'username': username,
      'place': place,
      'done': false,
    });
    if (context.mounted) {
      loadTasks(context, ref, todoCollection);
    }
  } catch (e) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text('タスクの追加中にエラーが発生しました: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // ignore: use_build_context_synchronously
  loadTasks(context, ref, todoCollection);
}
