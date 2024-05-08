import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaDeLogin extends StatelessWidget {
  const TelaDeLogin({Key? key}) : super(key: key);

  // Método para realizar o login do usuário
  void loginUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Se o login for bem-sucedido, navegue para a tela inicial
      Navigator.pushReplacementNamed(context, '/tela_inicial');
    } on FirebaseAuthException catch (e) {
      // Lidar com erros de autenticação
      print('Erro ao fazer login: $e');

      // Exibir mensagem de erro para o usuário
      String errorMessage = 'Erro ao fazer login';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = 'E-mail ou senha incorretos';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método para enviar um e-mail de redefinição de senha
  void resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Um e-mail de redefinição de senha foi enviado para $email'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Erro ao enviar e-mail de redefinição de senha: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar e-mail de redefinição de senha'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = ''; // Defina uma variável para armazenar o e-mail
    String password = ''; // Defina uma variável para armazenar a senha

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
                      labelText: 'Digite seu e-mail',
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
                      labelText: 'Digite sua senha',
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
                GestureDetector(
                  onTap: () {
                    // Chamar o método para enviar um e-mail de redefinição de senha
                    resetPassword(email, context);
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xB2000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navegar para a tela de cadastro
                    Navigator.pushNamed(context, '/tela_de_cadastro');
                  },
                  child: Text(
                    'Não possui conta? Cadastre-se',
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Color(0xB2000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Chamar o método para realizar o login do usuário
                    loginUser(email, password, context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'Login',
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0098FF), // Alterando a cor do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.7),
                    ),
                    shadowColor: Color(0x26FFFFFF),
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 7.5),
                      child: Opacity(
                        opacity: 0.7,
                        child: Text(
                          'ou',
                          style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.2,
                      left: -0.5,
                      right: 0,
                      child: Container(
                        height: 1.1,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.6),
                        child: SvgPicture.asset(
                          'assets/vectors/super_g_x2.svg',
                          width: 20.8,
                          height: 20.8,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 48,
                      height: 48,
                      child: SvgPicture.asset(
                        'assets/vectors/facebook_x2.svg',
                        width: 48,
                        height: 48,
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.3),
                        child: SvgPicture.asset(
                          'assets/vectors/shape_1_x2.svg',
                          width: 24,
                          height: 28.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
