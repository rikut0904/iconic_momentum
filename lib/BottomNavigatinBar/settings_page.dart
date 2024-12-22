import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigatinBar/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingsPage> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.purple,
                    iconSize: 30,
                    tooltip: 'ログアウト',
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }),
                        );
                      }
                    },
                  ),
                  const Text(
                    'ログアウト',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
