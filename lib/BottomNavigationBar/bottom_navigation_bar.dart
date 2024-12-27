import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigationBar/home.dart';
import 'package:iconic_momentum/BottomNavigationBar/calendar_page.dart';
import 'package:iconic_momentum/BottomNavigationBar/settings_page.dart';
import 'package:iconic_momentum/BottomNavigationBar/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomRoot extends ConsumerStatefulWidget {
  const BottomRoot({super.key});

  @override
  ConsumerState<BottomRoot> createState() => _BottomRootState();
}

class _BottomRootState extends ConsumerState<BottomRoot> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(indexProvider);
    final loginUI = ref.watch(loginProvider);

    // 各タブのページリスト
    final pages = [
      const CompletedToDoPage(
        completeToDo: [],
      ),
      const CalendarPage(
        todoItems: [],
      ),
      const SettingsPage(),
    ];

    // ボトムナビゲーションバーの項目
    const items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'カレンダー'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
    ];

    if (loginUI) {
      return Scaffold(
          body: pages[index], // 現在のインデックスに応じたページを表示
          bottomNavigationBar: BottomNavigationBar(
              items: items,
              currentIndex: index,
              selectedItemColor: Colors.purple[300],
              unselectedItemColor: Colors.black,
              onTap: (newIndex) {
                ref.read(indexProvider.notifier).state = newIndex; // インデックスを更新
              }));
    } else {
      return const Scaffold(body: LoginPage());
    }
  }
}
