import 'package:flutter/material.dart';

class LoginItem {
  final String name;
  final String mail;

  LoginItem({
    required this.name,
    required this.mail,
  });
}

class LoginPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const LoginPage({super.key, required this.LoginList});
  // ignore: non_constant_identifier_names
  final List<LoginItem> LoginList;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // ignore: unused_element, non_constant_identifier_names
  void _Login(BuildContext context) {}

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ログイン',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
