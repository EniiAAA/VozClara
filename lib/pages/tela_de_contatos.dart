import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaContatos extends StatelessWidget {
  const TelaContatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'), // Título da tela
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () {
                  _sendEmail(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(250, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0098FF)),
                ),
                icon: Icon(Icons.email, color: Colors.white),
                label: Text(
                  'Enviar Email',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () {
                  _openWhatsApp(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(250, 50)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF0098FF)),
                ),
                icon: Icon(Icons.message, color: Colors.white),
                label: Text(
                  'WhatsApp',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmail(BuildContext context) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'uninassal@edu.com',
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir o aplicativo de e-mail.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _openWhatsApp(BuildContext context) async {
    final Uri _whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '/+seu_numero',
    );

    if (await canLaunch(_whatsappUri.toString())) {
      await launch(_whatsappUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir o WhatsApp.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
