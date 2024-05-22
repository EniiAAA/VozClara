import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TelaTurmas extends StatefulWidget {
  final DatabaseReference turmasRef;

  TelaTurmas({Key? key, required this.turmasRef}) : super(key: key);

  @override
  _TelaTurmasState createState() => _TelaTurmasState();
}

class _TelaTurmasState extends State<TelaTurmas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turmas'),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: widget.turmasRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.value != null) {
              Map<dynamic, dynamic>? turmasMap =
                  dataSnapshot.value as Map<dynamic, dynamic>?;

              if (turmasMap != null) {
                List<dynamic> turmas = turmasMap.values.toList();
                return ListView.builder(
                  itemCount: turmas.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesTurma(turma: turmas[index]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.blue.shade50,
                          child: ListTile(
                            title: Text(
                              turmas[index]['nome'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            subtitle: Text(
                              turmas[index]['disciplina'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Center(
              child: Text('Nenhuma turma encontrada.'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar as turmas: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class QRCodeScreen extends StatelessWidget {
  final String data;

  QRCodeScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: data,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Escaneie o QR code para adicionar a turma',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class DetalhesTurma extends StatelessWidget {
  final Map<dynamic, dynamic> turma;

  DetalhesTurma({required this.turma});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(turma['nome']),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade800],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetalhe('Disciplina', turma['disciplina']),
                  _buildDetalhe('Professor', turma['professor']),
                  _buildDetalhe('Horário', turma['horario']),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _gerarQRCode(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Cor de fundo do botão
                          foregroundColor: Colors.white, // Cor do texto do botão
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Espaçamento interno do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Borda circular do botão
                          ),
                        ),
                        child: Text(
                          'Gerar QR Code',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _excluirTurma(context, turma['id']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Cor de fundo do botão
                          foregroundColor: Colors.white, // Cor do texto do botão
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Espaçamento interno do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // Borda circular do botão
                          ),
                        ),
                        child: Text(
                          'Excluir Turma',
                          style: TextStyle(
                            fontSize: 16,
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
      ),
    );
  }

  void _gerarQRCode(BuildContext context) {
    // Combine as informações da turma em uma string para ser usada como dados do QR code
    String data = 'Turma: ${turma['nome']}\nDisciplina: ${turma['disciplina']}\nProfessor: ${turma['professor']}\nHorário: ${turma['horario']}';

    // Navegue para a próxima tela para exibir o QR code
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeScreen(data: data),
      ),
    );
  }

void _excluirTurma(BuildContext context, String turmaId) {
  print('Tentando excluir turma com ID: $turmaId');
  DatabaseReference turmasRef = FirebaseDatabase.instance.reference().child('turmas');
  
  turmasRef.child(turmaId).remove().then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Turma excluída com sucesso!')),
    );
    
    Navigator.pop(context); // Volta para a tela anterior após excluir a turma
  }).catchError((error) {
    print('Erro ao excluir a turma: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao excluir a turma: $error')),
    );
  });
}
  Widget _buildDetalhe(String titulo, String? valor) {
    if (valor == null || valor.isEmpty) {
      // Se o valor for nulo ou vazio, exibir "N/A"
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'N/A',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontFamily: 'OpenSans',
            ),
          ),
          SizedBox(height: 16),
          Divider(height: 2, color: Colors.grey[300]),
        ],
      );
    } else {
      // Se houver um valor válido, exibir normalmente
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 8),
          Text(
            valor,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontFamily: 'OpenSans',
            ),
          ),
          SizedBox(height: 16),
          Divider(height: 2, color: Colors.grey[300]),
        ],
      );
    }
  }
}