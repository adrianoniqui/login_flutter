
// Importamos los widgets preconstruidos para poder crear la interfaz de usuario.
import 'package:flutter/material.dart';

// Esta clase es fundamental para conectarnos con la plataforma de Firebase y utilizar sus herramientas.
import 'package:firebase_core/firebase_core.dart';


import 'package:proyecto_propio/login_page.dart';

// Esta línea configura la conexión de la aplicación con Firestore utilizando las opciones especificadas.
import 'firebase_options.dart';



void main() async {
  // Asegura que los bindings de Flutter estén inicializados antes de cualquier operación asíncrona.
  
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa Firebase con las opciones específicas para la plataforma actual, esperando a que esta operación se complete.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}


  



 
