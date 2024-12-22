import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigatinBar/home.dart';
import 'package:iconic_momentum/BottomNavigatinBar/calendar_page.dart';
import 'package:iconic_momentum/BottomNavigatinBar/settings_page.dart';
import 'package:iconic_momentum/BottomNavigatinBar/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottonRoot extends ConsumerStatefulWidget {
  const BottonRoot({super.key});

  @override
  ConsumerState<BottonRoot> createState() => _BottonRootState();
}

class _BottonRootState extends ConsumerState<BottonRoot> {
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
