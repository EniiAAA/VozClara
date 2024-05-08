import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 

import 'package:flutter_app/pages/tela_de_carregamento.dart';
import 'package:flutter_app/pages/tela_de_login.dart' as LoginScreen; // Renomeando para LoginScreen
import 'package:flutter_app/pages/tela_inicial.dart';
import 'package:flutter_app/pages/tela_de_cadastro.dart';
import 'package:flutter_app/pages/tela_de_contatos.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      initialRoute: '/tela_de_carregamento',
      routes: {
        '/tela_de_carregamento': (context) => TelaDeCarregamento(),
        '/tela_de_login': (context) => LoginScreen.TelaDeLogin(), // Usando o alias
        '/tela_de_cadastro': (context) => TelaDeCadastro(),
        '/tela_inicial': (context) => TelaInicial(),
        '/tela_de_contatos':(context) => TelaContatos(),
      },
    );
  }
}
