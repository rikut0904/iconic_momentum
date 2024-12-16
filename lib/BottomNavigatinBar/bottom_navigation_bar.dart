import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconic_momentum/BottomNavigatinBar/calendar_page.dart';
import 'package:iconic_momentum/BottomNavigatinBar/settings_page.dart';
import 'package:iconic_momentum/BottomNavigatinBar/tasks_page.dart';
import 'package:iconic_momentum/BottomNavigatinBar/home.dart';
import 'package:iconic_momentum/main.dart';

class BottonRoot extends ConsumerWidget {
  const BottonRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);

    // 各タブのページリスト
    final pages = [
      const Homeroute(),
      const CompletedTasksPage(
        completedTasks: [],
      ),
      const CalendarPage(),
      const SettingsPage(),
    ];

    // ボトムナビゲーションバーの項目
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
      BottomNavigationBarItem(icon: Icon(Icons.done_all), label: '完了タスク'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'カレンダー'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
    ];

    return Scaffold(
      body: pages[index], // 現在のインデックスに応じたページを表示
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: index,
        selectedItemColor: Colors.purple[300],
        unselectedItemColor: Colors.black,
        onTap: (newIndex) {
          ref.read(indexProvider.notifier).state = newIndex; // インデックスを更新
        },
      ),
    );
  }
}
