import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecoverPager extends StatefulWidget{
  @override
  _RecoverPageState createState() => _RecoverPageState(); 
}

class _RecoverPageState extends State<RecoverPager>{
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recover Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: _recover, child: const Text('Recover')),
        ],),
      ),
    );
  }

  void _recover() async{
    try{
      final user = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailController.text.trim())
          .get();

      if (user.docs.isNotEmpty) {
        final password = user.docs.first['password'];
        print('Password recoverd: $password');
        _showSnackBar('Password: $password');
      }

    }catch (e){
        print('recovery failed: $e');
        _showSnackBar('recovery failed: $e');
    }
  }

  void _showSnackBar(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}