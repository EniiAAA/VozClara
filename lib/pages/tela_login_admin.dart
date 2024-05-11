import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaLoginAdmin extends StatelessWidget {
  const TelaLoginAdmin({Key? key}) : super(key: key);

  // Método para realizar o login do administrador
  void loginAdmin(String email, String password, BuildContext context) async {
    try {
      // Verifica se o email e a senha correspondem ao administrador
      if (email == 'adminturma@vozclara.com' && password == 'admin123') {
        // Se as credenciais estiverem corretas, redirecione para a tela inicial do administrador
        Navigator.pushReplacementNamed(context, '/tela_inicial_admin');
      } else {
        // Se as credenciais estiverem incorretas, exiba uma mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Credenciais inválidas. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Lidar com erros de autenticação
      print('Erro ao fazer login do administrador: $e');

      // Exibir mensagem de erro para o administrador
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer login do administrador'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = ''; // Variável para armazenar o e-mail
    String password = ''; // Variável para armazenar a senha

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Implemente a navegação para a tela inicial
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/voz_claralogo_4.png',
                        ),
                      ),
                    ),
                    width: 194,
                    height: 194,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 289.6,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      labelText: 'Digite seu e-mail (Admin)',
                    ),
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x99000000),
                    ),
                    onChanged: (value) {
                      // Atualize o valor do email conforme o usuário digita
                      email = value;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 289.6,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      labelText: 'Digite sua senha (Admin)',
                      suffixIcon: IconButton(
                        onPressed: () {
                          // Implemente a lógica para alternar a visibilidade da senha
                        },
                        icon: Icon(Icons.visibility),
                      ),
                    ),
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0x99000000),
                    ),
                    onChanged: (value) {
                      // Atualize o valor da senha conforme o usuário digita
                      password = value;
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Chamar o método para realizar o login do administrador
                    loginAdmin(email, password, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      'Login (Admin)',
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF0098FF), // Alterando a cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.7),
                    ),
                    shadowColor: Color(0x26FFFFFF),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
