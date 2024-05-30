import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String email;

  WelcomePage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text(
          'Welcome, $email',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
