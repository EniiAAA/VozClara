import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tela_de_contatos.dart';
import 'tela_de_transcricao.dart'; 

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  late List<String> _turmasLidas;

  @override
  void initState() {
    super.initState();
    _carregarTurmasLidas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(19, 30, 19, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
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
                        image: AssetImage('assets/images/voz_claralogo_4.png'),
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
                      _showContactOptions(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0xFF0098FF),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Contato',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LerQRCodeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0xFF0098FF),
                    ),
                    child: Text(
                      'Ler QR CODE',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _acessarTurmas(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0xFF0098FF),
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

  void _performLogoff(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/tela_de_carregamento', (route) => false);
  }

  void _acessarTurmas(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaHistorico(turmas: _turmasLidas)),
    );
  }

  Future<void> _carregarTurmasLidas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _turmasLidas = prefs.getStringList('turmasLidas') ?? []; 
    setState(() {});
  }

  void _showContactOptions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaContatos()),
    );
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
      print('Data scanned: ${scanData.code}');
      _adicionarTurmaLida(scanData.code!);
      Navigator.pop(context); 
    });
  }

  Future<void> _adicionarTurmaLida(String qrData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? turmasLidas = prefs.getStringList('turmasLidas');
    if (turmasLidas == null) {
      turmasLidas = [];
    }
    turmasLidas.add(qrData); 
    await prefs.setStringList('turmasLidas', turmasLidas);
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }
}

class TelaHistorico extends StatefulWidget {
  final List<String> turmas; 
  const TelaHistorico({Key? key, required this.turmas}) : super(key: key);

  @override
  _TelaHistoricoState createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico'),
      ),
      body: Center(
        child: _buildListaTurmas(widget.turmas),
      ),
    );
  }

  Widget _buildListaTurmas(List<String> turmas) { 
    return ListView.builder(
      itemCount: turmas.length,
      itemBuilder: (context, index) {
        final sala = turmas[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaTranscricao(sala: sala), 
                ),
              );
            },
            child: Text(sala),
          ),
        );
      },
    );
  }
}
