import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:iconic_momentum/dropdown_provider/dropdown_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconic_momentum/BottomNavigationBar/webview.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: constant_identifier_names
const GitURL = "https://github.com/rikut0904/iconic_momentum";

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingPage();
}

class _SettingPage extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(infoName);
    final userEmail = ref.watch(infoEmail);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Iconic Momentum',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[300], // AppBarの色
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('設定', style: TextStyle(fontSize: 24)),
            Text('ユーザー名 : $userName', style: const TextStyle(fontSize: 18)),
            Text('メールアドレス : $userEmail', style: const TextStyle(fontSize: 18)),
            const Text('github : ', style: TextStyle(fontSize: 18)),
            TextButton(
              onPressed: () {
                if (!kIsWeb) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const WebViewPage(
                        title: "GitHub",
                        url: GitURL,
                      ),
                    ),
                  );
                } else {
                  _launchURL(GitURL);
                }
              },
              child: const Text(
                GitURL,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text('プライバシーポリシー : ', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    //画面遷移情報
                    ref.read(indexProvider.notifier).state = 0;
                    ref.read(loginProvider.notifier).state = false;
                    //ログイン情報
                    ref.read(infoID.notifier).state = "Null";
                    ref.read(infoName.notifier).state = "ゲスト";
                    ref.read(infoEmail.notifier).state = "Null";
                    //グループ機能
                    ref.read(groupTagProvider.notifier).state = "個人";
                    ref.read(dropdownValueProvider.notifier).state = "個人";
                    ref.read(groupListProvider.notifier).state = [
                      "追加",
                      "全て",
                      "個人"
                    ];
                    // タスクリスト
                    ref.read(infoTodoItems.notifier).state = [];
                    ref.read(infoCompletedItems.notifier).state = [];
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomRoot(),
                      ),
                    );
                  }
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 10),
                    Text(
                      'ログアウト',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('made by 逃走中'),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'このURLを開けません: $url';
    }
  }
}
