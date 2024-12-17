import 'package:flutter_riverpod/flutter_riverpod.dart';

/// TodoItem のクラス定義
class TodoItem {
  final String title;
  final String content;
  final String schedule;
  final bool done;

  TodoItem({
    required this.title,
    required this.content,
    required this.schedule,
    required this.done,
  });

  /// copyWith メソッドで値を更新
  TodoItem copyWith({
    String? title,
    String? content,
    String? schedule,
    bool? done,
  }) {
    return TodoItem(
      title: title ?? this.title,
      content: content ?? this.content,
      schedule: schedule ?? this.schedule,
      done: done ?? this.done,
    );
  }
}

/// タスクリストを管理する StateNotifier
class TaskNotifier extends StateNotifier<List<TodoItem>> {
  TaskNotifier() : super([]);

  /// 新しいタスクを追加
  void addTask(String title, String content, String schedule) {
    state = [
      ...state,
      TodoItem(title: title, content: content, schedule: schedule, done: false),
    ];
  }

  /// タスクを削除
  void removeTask(int index) {
    state = List.from(state)..removeAt(index);
  }

  /// タスクの完了状態を切り替え
  void toggleTaskDone(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(done: !state[i].done)
        else
          state[i]
    ];
  }
}

/// タスクリスト用プロバイダー
final taskProvider = StateNotifierProvider<TaskNotifier, List<TodoItem>>(
  (ref) => TaskNotifier(),
);
