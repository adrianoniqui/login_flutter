import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteAccountPage extends StatefulWidget{
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState(); 
}

class _DeleteAccountPageState extends State<DeleteAccountPage>{
  
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete account'),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: _delete, child: Text('Delete')),
      ],),),
    );
  }

  void _delete() async{
    try {
      final user = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: _emailController.text.trim()).get();
      if (user.docs.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(user.docs.first.id).delete();
        print('user deleted');
        _showSnackBar('user deleted');
        Navigator.pop(context);
      }
    } catch (e) {
      print('deleted failed: $e');
      _showSnackBar('delete failed $e');
    }
  }

  void _showSnackBar(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}