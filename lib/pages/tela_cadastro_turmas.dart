import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'tela_inicial_admin.dart'; // Importe a tela inicial ou o local onde ela é definida

class TelaCadastroTurma extends StatelessWidget {
  final DatabaseReference turmasRef;

  TelaCadastroTurma({Key? key, required this.turmasRef}) : super(key: key);

  Future<void> _salvarTurma(BuildContext context, String codigo, String nome, String disciplina, String professor, String horario) async {
    if (codigo.isEmpty || nome.isEmpty || disciplina.isEmpty || professor.isEmpty || horario.isEmpty) {
      // Se algum campo estiver vazio, exibir um diálogo de alerta
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Campos Incompletos'),
          content: Text('Por favor, preencha todos os campos antes de salvar.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return; // Encerra a execução da função caso haja campos vazios
    }

    // Verifica se já existe uma turma com o mesmo código
    try {
      final DataSnapshot dataSnapshot = (await turmasRef.orderByChild('codigo').equalTo(codigo).once()).snapshot;

      final Map<dynamic, dynamic>? turmasMap = dataSnapshot.value as Map<dynamic, dynamic>?;

      if (turmasMap != null && turmasMap.isNotEmpty) {
        // Se já existir uma turma com o mesmo código, exibir um diálogo de alerta
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Código Existente'),
            content: Text('Já existe uma turma cadastrada com este código. Por favor, escolha outro código.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Encerra a execução da função
      }

      // Se não houver uma turma com o mesmo código, salvar a turma
      await turmasRef.push().set({
        'codigo': codigo,
        'nome': nome,
        'disciplina': disciplina,
        'professor': professor,
        'horario': horario,
      });

      // Exibe um SnackBar de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Turma cadastrada com sucesso')),
      );

      // Navega de volta para a tela inicial após o sucesso do cadastro
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TelaInicialAdmin()), // Substitua "TelaInicial()" pelo nome da sua tela inicial
        (route) => false,
      );
    } catch (error) {
      // Exibe um aviso de erro
      _exibirAviso(context, 'Erro ao cadastrar turma: $error');
    }
  }

  void _exibirAviso(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Aviso'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String codigo = '';
    String nome = '';
    String disciplina = '';
    String professor = '';
    String diaSemana = 'Segunda-Feira'; // Valor inicial padrão
    String horario = '';

    // Opções para o dropdown de dias da semana
    final List<String> diasSemana = [
      'Segunda-Feira',
      'Terça-Feira',
      'Quarta-Feira',
      'Quinta-Feira',
      'Sexta-Feira',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Turma'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Código da Turma',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => codigo = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome da Turma',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => nome = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Disciplina',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => disciplina = value,
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Professor Responsável',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => professor = value,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Dia da Semana',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: diaSemana,
                      onChanged: (value) {
                        diaSemana = value.toString();
                      },
                      items: diasSemana.map((dia) {
                        return DropdownMenuItem(
                          value: dia,
                          child: Text(dia),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Horário',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) => horario = value,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _salvarTurma(context, codigo, nome, disciplina, professor, '$diaSemana - $horario');
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
