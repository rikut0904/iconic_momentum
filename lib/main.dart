import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iconic_momentum/firebase_options.dart';
import 'package:iconic_momentum/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//画面遷移情報
final indexProvider = StateProvider<int>((ref) => 0);
final loginProvider = StateProvider<bool>((ref) => false);
//ログイン情報
final infoID = StateProvider<String>((ref) => "Null");
final infoName = StateProvider<String>((ref) => "ゲスト");
final infoEmail = StateProvider<String>((ref) => "Null");
// タスクリスト
final infoTodoItems = StateProvider<List<TodoItem>>((ref) => []);
final infoCompletedItems = StateProvider<List<TodoItem>>((ref) => []);

//ToDoリストの初期化
class TodoItem {
  final String title;
  final String content;
  final String schedule;
  final String username;
  final String place;
  bool done;

  TodoItem({
    required this.title,
    required this.content,
    required this.schedule,
    required this.username,
    required this.place,
    this.done = false,
  });

  // Firestoreからデータを読み込む
  factory TodoItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoItem(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      schedule: data['schedule'] ?? '',
      username: data['username'] ?? '',
      place: data['place'] ?? '',
      done: data['done'] ?? false,
    );
  }

  // Firestoreにデータを保存する形式に変換
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'schedule': schedule,
      'username': username,
      'place': place,
      'done': done,
    };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ja_JP', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    if (Platform.isAndroid) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    } else if (Platform.isIOS) {
      WebViewPlatform.instance = WebKitWebViewPlatform();
    }
  }
  runApp(const ProviderScope(child: MyApp()));
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
      home: const BottomRoot(),
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
