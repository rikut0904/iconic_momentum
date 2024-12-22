import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigatinBar/bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingPage();
}

class _SettingPage extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
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
              const Text('設定画面-以下記述するもの-', style: TextStyle(fontSize: 24)),
              const Text('githubリンク公開', style: TextStyle(fontSize: 18)),
              const Text('プライバシーポリシー', style: TextStyle(fontSize: 18)),
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
                      ref.read(loginProvider.notifier).state = false;
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottonRoot(),
                        ),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout,size: 18),
                      SizedBox(width: 10),
                      Text(
                        'ログアウト',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],),
                ),
              ),
            ],
          ),
        ));
  }
}
