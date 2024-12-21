import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String infoText = "";
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iconic Momentum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ログイン',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'メールアドレス:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'メールアドレスを入力'),
            ),
            const SizedBox(height: 30),
            const Text(
              'パスワード:',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextField(
                controller: password,
                decoration: const InputDecoration(
                  hintText: 'パスワードを入力',
                  
                ),
                obscureText: true
                ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
