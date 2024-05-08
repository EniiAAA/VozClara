import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'tela_de_contatos.dart'; // Importe a tela de contatos

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(19, 30, 19, 50), // Ajustei o padding superior
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      // Adicione a lógica para o logoff
                      _performLogoff(context);
                    },
                    child: Icon(Icons.logout),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/voz_claralogo_4.png',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 214,
                      height: 220,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Lorem ipsum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Abrir a câmera para realizar a leitura do QRCode da turma
                      _openCamera(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Define a borda menos arredondada
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)), // Define a largura mínima
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0098FF)), // Define a cor de fundo do botão
                    ),
                    child: Text(
                      'Ler QRCode da Turma',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Define a cor do texto dentro do botão
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar para as turmas que o aluno já leu o QRCode
                      _navigateToTurmasLidas(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Define a borda menos arredondada
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)), // Define a largura mínima
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0098FF)), // Define a cor de fundo do botão
                    ),
                    child: Text(
                      'Turmas Lidas',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Define a cor do texto dentro do botão
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Mostrar as opções de contato da instituição
                      _showContactOptions(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Define a borda menos arredondada
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)), // Define a largura mínima
                      backgroundColor: MaterialStateProperty.all(Color(0xFF0098FF)), // Define a cor de fundo do botão
                    ),
                    child: Text(
                      'Contato',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Define a cor do texto dentro do botão
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para realizar o logoff
  void _performLogoff(BuildContext context) {
    // Adicione aqui a lógica para realizar o logoff do usuário
    // Por exemplo, você pode limpar o token de autenticação e redirecionar o usuário para a tela de login.
    // Neste exemplo, estamos apenas navegando de volta para a tela de login e removendo todas as rotas anteriores.
    Navigator.pushNamedAndRemoveUntil(context, '/tela_de_login', (route) => false);
  }

  // Função para abrir a câmera
  void _openCamera(BuildContext context) {
    // Adicione aqui a lógica para abrir a câmera para ler o QRCode da turma
    // Esta é apenas uma simulação para fins de exemplo
    print('Abrindo a câmera...');
  }

  // Função para navegar para as turmas lidas
  void _navigateToTurmasLidas(BuildContext context) {
    // Adicione aqui a lógica para navegar para a tela de turmas lidas
    // Esta é apenas uma simulação para fins de exemplo
    print('Navegando para as turmas lidas...');
  }

  // Função para mostrar as opções de contato da instituição
  void _showContactOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaContatos()),
    );
  }
}
