import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iconic_momentum/BottomNavigatinBar/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            const SizedBox(height: 40),
            const Text(
              'ユーザー登録',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 70),
            const Text(
              'メールアドレス',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'メールアドレスを入力してください'),
            ),
            const SizedBox(height: 30),
            const Text(
              'ユーザー名',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(hintText: 'ユーザー名を入力してください'),
            ),
            const SizedBox(height: 30),
            const Text(
              'パスワード',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'パスワードを入力してください',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                obscureText: _isObscure),
            const SizedBox(height: 30),
            Text(infoText),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text(
                  '登録',
                  style: TextStyle(
                      color: Color.fromARGB(255, 156, 39, 176), fontSize: 15),
                ),
                onPressed: () async {
                  final loginName = name.text.trim();
                  final loginEmail = email.text.trim();
                  final loginPassword = password.text.trim();
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    await auth.createUserWithEmailAndPassword(
                        email: loginEmail, password: loginPassword);
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const CompletedToDoPage(completeToDo: []);
                      }),
                    );
                  } catch (e) {
                    setState(() {
                      (() {
                        infoText = "ユーザー登録に失敗しました。:${e.toString()}";
                      });
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
