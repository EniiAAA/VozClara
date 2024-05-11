import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'tela_de_contatos.dart'; 
import 'tela_historico.dart'; // Importe a tela de histórico

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
            padding: EdgeInsets.fromLTRB(
                19, 30, 19, 50), // Ajustei o padding superior
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
                    width: 214,
                    height: 220,
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Define a borda menos arredondada
                      ),
                      minimumSize: Size(double.infinity, 50), // Define a largura mínima
                      backgroundColor: Color(0xFF0098FF), // Define a cor de fundo do botão
                      padding: EdgeInsets.zero, // Define o padding do botão
                    ),
                    child: Text(
                      'Contato',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Define a cor do texto dentro do botão
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Adiciona espaçamento entre os botões
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione a lógica para ler o QR CODE
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LerQRCodeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Define a borda menos arredondada
                      ),
                      minimumSize: Size(double.infinity, 50), // Define a largura mínima
                      backgroundColor: Color(0xFF0098FF), // Define a cor de fundo do botão
                    ),
                    child: Text(
                      'Ler QR CODE',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF), // Define a cor do texto dentro do botão
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Adiciona espaçamento entre os botões
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione a lógica para acessar suas turmas
                      _acessarTurmas(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Define a borda menos arredondada
                      ),
                      minimumSize: Size(double.infinity, 50), // Define a largura mínima
                      backgroundColor: Color(0xFF0098FF), // Define a cor de fundo do botão
                    ),
                    child: Text(
                      'Acessar suas turmas',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
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
    Navigator.pushNamedAndRemoveUntil(
        context, '/tela_de_carregamento', (route) => false);
  }

  // Função para mostrar as opções de contato da instituição
  void _showContactOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaContatos()),
    );
  }

  // Função para acessar suas turmas
  void _acessarTurmas(BuildContext context) {
    // Adicione aqui a lógica para acessar as turmas do usuário
  }
}

class LerQRCodeScreen extends StatefulWidget {
  const LerQRCodeScreen({Key? key}) : super(key: key);

  @override
  _LerQRCodeScreenState createState() => _LerQRCodeScreenState();
}

class _LerQRCodeScreenState extends State<LerQRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ler QR Code'),
      ),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Aqui você pode lidar com os dados do QR Code após a leitura
      // Por exemplo, você pode processar os dados, exibir em um diálogo, etc.
      print('Data scanned: ${scanData.code}');
      
      // Navegar para a tela 'tela_histórico' após a leitura do QR Code
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaHistorico()), // Navega para a tela de histórico
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
