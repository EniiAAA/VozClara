import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/pages/tela_de_carregamento.dart';
import 'package:flutter_app/pages/tela_de_login.dart' as LoginScreen;
import 'package:flutter_app/pages/tela_inicial.dart';
import 'package:flutter_app/pages/tela_de_cadastro.dart';
import 'package:flutter_app/pages/tela_de_contatos.dart';
import 'package:flutter_app/pages/tela_de_transcricao.dart';
import 'package:flutter_app/pages/tela_inicial_admin.dart';
import 'package:flutter_app/pages/tela_login_admin.dart';
import 'package:flutter_app/pages/tela_cadastro_turmas.dart';
import 'package:flutter_app/pages/tela_de_turmas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Criando uma instância do Firebase Database
    final DatabaseReference _turmasRef = FirebaseDatabase.instance.reference().child('turmas');

    return MaterialApp(
      title: 'Flutter App',
      initialRoute: '/tela_de_carregamento',
      routes: {
        '/tela_de_carregamento': (context) => TelaDeCarregamento(),
        '/tela_de_contatos': (context) => TelaContatos(),
        '/tela_de_login': (context) => LoginScreen.TelaDeLogin(),
        '/tela_de_cadastro': (context) => TelaDeCadastro(),
        '/tela_inicial': (context) => TelaInicial(),
        '/tela_inicial_admin': (context) => TelaInicialAdmin(),
        '/tela_login_admin': (context) => TelaLoginAdmin(),
        '/tela_cadastro_turmas': (context) => TelaCadastroTurma(turmasRef: _turmasRef),
        '/tela_de_turmas': (context) => TelaTurmas(turmasRef: _turmasRef), 
        '/tela_de_transcricao': (context) => TelaTranscricao(sala: ModalRoute.of(context)!.settings.arguments as String)
      },
    );
  }
}