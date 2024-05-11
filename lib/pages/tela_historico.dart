import 'package:flutter/material.dart';

class TelaHistorico extends StatelessWidget {
  const TelaHistorico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Histórico de Salas:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Número de itens no histórico
                itemBuilder: (context, index) {
                  // Aqui você pode construir cada item da lista
                  return ListTile(
                    title: Text('Sala ${index + 1}'),
                    subtitle: Text('Data e hora'), // Substitua com a data e hora da sala
                    onTap: () {
                      // Aqui você pode adicionar a lógica para abrir detalhes da sala
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
