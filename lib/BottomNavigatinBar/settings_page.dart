import 'package:flutter/material.dart';

typedef TodoItem = ({String title, bool done});

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Iconic Momentum',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purple[300], // AppBarの色
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('設定画面-以下記述するもの-', style: TextStyle(fontSize: 24)),
              Text('githubリンク公開', style: TextStyle(fontSize: 18)),
              Text('プライバシーポリシー', style: TextStyle(fontSize: 18)),
              Text('ログアウトボタン', style: TextStyle(fontSize: 18)),
            ],
          ),
        ));
  }
}
