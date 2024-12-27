import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconic_momentum/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_menu.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_riverpod.dart';

Future<void> loadTasks(BuildContext context, WidgetRef ref,
    CollectionReference todoCollection) async {
  final loginName = ref.watch(infoName);
  try {
    final userNameSnapshot =
        todoCollection.where('username', isEqualTo: loginName);
    final todosSnapshot =
        await userNameSnapshot.where('done', isEqualTo: false).get();
    final completedSnapshot =
        await userNameSnapshot.where('done', isEqualTo: true).get();
    ref.read(infoTodoItems.notifier).update((state) =>
        todosSnapshot.docs.map((doc) => TodoItem.fromFirestore(doc)).toList());
    ref.read(infoCompletedItems.notifier).update((state) => completedSnapshot
        .docs
        .map((doc) => TodoItem.fromFirestore(doc))
        .toList());
  } catch (e) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('読み取りエラー'),
          content: Text('タスクのロード中にエラーが発生しました: $e'),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Firestoreでタスクの状態を更新
Future<void> updateTaskDone(BuildContext context, WidgetRef ref, String title,
    bool done, _todoCollection) async {
  final snapshot = await _todoCollection.where('title', isEqualTo: title).get();
  for (var doc in snapshot.docs) {
    await doc.reference.update({'done': done});
  }
  // ignore: use_build_context_synchronously
  loadTasks(context, ref, _todoCollection);
}

// チェックボックスを押した際の処理
void onCheckboxChanged(BuildContext context, WidgetRef ref, TodoItem item,
    bool? value, _todoCollection) async {
  if (value != null) {
    await updateTaskDone(context, ref, item.title, value, _todoCollection);
    if (context.mounted) {
      loadTasks(context, ref, _todoCollection);
    }
  }
}

// Firestoreでタスクを削除
Future<void> deleteTask(
    BuildContext context, WidgetRef ref, String title, _todoCollection) async {
  final snapshot = await _todoCollection.where('title', isEqualTo: title).get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
  // ignore: use_build_context_synchronously
  loadTasks(context, ref, _todoCollection); // ローカルデータを再読み込み
}
