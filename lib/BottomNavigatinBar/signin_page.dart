import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconic_momentum/main.dart';
import 'package:iconic_momentum/BottomNavigatinBar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPage();
}

class _SigninPage extends ConsumerState<SigninPage> {
  String infoText = "";
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Iconic Momentum',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
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
            SizedBox(
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
                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                      email: loginEmail,
                      password: loginPassword,
                    );
                    final FirebaseFirestore firestore =
                        FirebaseFirestore.instance;
                    final userId = userCredential.user!.uid;
                    await firestore
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .set({
                      'uid': userId, // FirestoreにUIDを保存
                      'username': loginName,
                      'email': loginEmail,
                      'createdAt': FieldValue.serverTimestamp(),
                    });
                    ref.read(loginProvider.notifier).state = true;
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottonRoot(),
                      ),
                    );
                  } catch (e) {
                    setState(() {
                      infoText = "ユーザー登録に失敗しました。:${e.toString()}";
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
