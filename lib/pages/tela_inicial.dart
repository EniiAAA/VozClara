import 'package:flutter/material.dart';

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
                ElevatedButton(
                  onPressed: () {
                    // Abrir a câmera para realizar a leitura do QRCode da turma
                  },
                  child: Text('Ler QRCode da Turma'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navegar para as turmas que o aluno já leu o QRCode
                  },
                  child: Text('Turmas Lidas'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Mostrar as opções de contato da instituição
                  },
                  child: Text('Contato'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
