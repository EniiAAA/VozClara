import 'package:flutter/material.dart';

class TelaDeCarregamento extends StatelessWidget {
  const TelaDeCarregamento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/voz_claralogo_4.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navegar para a tela de login do admin
                  Navigator.pushNamed(context, '/tela_login_admin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0098FF), // Cor do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.7), // Borda arredondada
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'ADMIN',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navegar para a tela de login do aluno
                  Navigator.pushNamed(context, '/tela_de_login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0098FF), // Cor do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.7), // Borda arredondada
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'ALUNO',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
