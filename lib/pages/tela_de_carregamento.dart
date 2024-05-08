import 'dart:async';
import 'package:flutter/material.dart';

class TelaDeCarregamento extends StatefulWidget {
  const TelaDeCarregamento({Key? key}) : super(key: key);

  @override
  _TelaDeCarregamentoState createState() => _TelaDeCarregamentoState();
}

class _TelaDeCarregamentoState extends State<TelaDeCarregamento> {
  @override
  void initState() {
    super.initState();
    // Inicia o timer para navegar para a tela de login após 5 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/tela_de_login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            'assets/images/voz_claralogo_4.png',
            width: 265,
            height: 265,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
