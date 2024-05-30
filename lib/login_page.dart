import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_page.dart';
import 'register_page.dart';
import 'recover_page.dart';
import 'delete_account_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Create Account'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecoverPager()),
                );
              },
              child: Text('Recover Account'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteAccountPage()),
                );
              },
              child: Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailController.text.trim())
          .where('password', isEqualTo: _passwordController.text.trim())
          .get();

      if (user.docs.isNotEmpty) {
        print('Login successful');
        _showSnackBar('Login successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage(email: _emailController.text.trim())),
        );
      } else {
        print('Login failed: User not found');
        _showSnackBar('Login failed: User not found');
      }
    } catch (e) {
      print('Login failed: $e');
      _showSnackBar('Login failed: $e');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

