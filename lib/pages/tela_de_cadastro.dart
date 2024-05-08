import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class TelaDeCadastro extends StatelessWidget {
  TelaDeCadastro({Key? key}) : super(key: key);

  //chave global para o formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Declaração dos controladores de texto
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Método para salvar os dados do usuário no Realtime Database
  Future<void> saveUserData(String nome, int matricula, String email) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    try {
      await databaseReference.child('users').child(email.replaceAll('.', ',')).set({
        'nome': nome,
        'matricula': matricula,
        'email': email,
      });
    } catch (e) {
      // Lidar com erros de salvamento no banco de dados
      print('Erro ao salvar dados do usuário: $e');
    }
  }

  // Método para realizar o cadastro do usuário
  void registerUser(BuildContext context) async {
    final nome = nomeController.text;
    final matricula = matriculaController.text;
    final email = emailController.text;
    final password = passwordController.text;

    // Verifica se todos os campos estão preenchidos
    if (nome.isEmpty || matricula.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todos os campos são obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Verifica se o e-mail possui um formato válido
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Formato de e-mail inválido'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Verifica se o número de matrícula possui exatamente 8 dígitos
    if (matricula.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Número de matrícula deve ter exatamente 8 dígitos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Se o cadastro for bem-sucedido, salve os dados do usuário no Realtime Database
      await saveUserData(nome, int.parse(matricula), email);

      // Exibir mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro feito com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navegar para a tela inicial
      Navigator.pushReplacementNamed(context, '/tela_inicial');
    } on FirebaseAuthException catch (e) {
      // Lidar com erros de cadastro
      print('Erro ao cadastrar: $e');

      String errorMessage = 'Erro ao fazer cadastro';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'E-mail já em uso. Tente fazer login ou recuperar a senha.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'), // Título da tela
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de voltar
          onPressed: () {
            Navigator.pop(context); // Navega de volta para a tela anterior (login)
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              // Use a chave global para o formulário
              key: _formKey,
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
                      controller: nomeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.7),
                        ),
                        labelText: 'Nome Completo',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome obrigatório';
                        }
                        return null;
                      },
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 289.6,
                    child: TextFormField(
                      controller: matriculaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.7),
                        ),
                        labelText: 'Número de matrícula',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Número de matrícula obrigatório';
                        }
                        if (value.length != 8) {
                          return 'Número de matrícula deve ter 8 dígitos';
                        }
                        return null;
                      },
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 289.6,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.7),
                        ),
                        labelText: 'Digite seu e-mail',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'E-mail obrigatório';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 289.6,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.7),
                        ),
                        labelText: 'Digite sua senha',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Senha obrigatória';
                        }
                        return null;
                      },
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0x99000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Verifica se o formulário é válido antes de registrar o usuário
                      if (_formKey.currentState!.validate()) {
                        registerUser(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        'Cadastrar',
                        style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0098FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.7),
                      ),
                      shadowColor: Color(0x26FFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
