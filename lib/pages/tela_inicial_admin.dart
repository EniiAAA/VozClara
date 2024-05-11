import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/pages/tela_cadastro_turmas.dart';
import 'package:flutter_app/pages/tela_de_turmas.dart';

class TelaInicialAdmin extends StatelessWidget {
  TelaInicialAdmin({Key? key}) : super(key: key);

  final DatabaseReference _turmasRef =
      FirebaseDatabase.instance.reference().child('turmas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
            onPressed: () {
              _performLogout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'O que você deseja fazer?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            _buildElevatedButton(
              context,
              'Cadastrar Turmas',
              Icons.add_box_outlined,
              () => _cadastrarTurmas(context),
            ),
            SizedBox(height: 20),
            _buildElevatedButton(
              context,
              'Visualizar Turmas Cadastradas',
              Icons.list_alt,
              () => _visualizarTurmas(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedButton(
    BuildContext context,
    String label,
    IconData icon,
    void Function() onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void _performLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/tela_de_carregamento',
      (route) => false,
    );
  }

  void _cadastrarTurmas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaCadastroTurma(turmasRef: _turmasRef),
      ),
    );
  }

  void _visualizarTurmas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaTurmas(turmasRef: _turmasRef),
      ),
    );
  }
}
