import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _register, child: Text('register')),

          ],
        ),
      ),
    );
  }

  void _register() async{
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(),
      });
    } catch (e) {
      print('registration failed: $e');
      _showSnackBar('registration failed : $e');
    }
  }
  void _showSnackBar(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}