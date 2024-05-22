import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart'; 

class TelaTranscricao extends StatefulWidget {
  final String sala;
  const TelaTranscricao({Key? key, required this.sala}) : super(key: key);

  @override
  _TelaTranscricaoState createState() => _TelaTranscricaoState();
}

class _TelaTranscricaoState extends State<TelaTranscricao> {
  bool _isRecording = false;
  bool _isLoading = false;
  String _transcriptionResult = '';
  String? _recordedFilePath;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  final String _apiKey = 'YOUR_GOOGLE_API_KEY'; // Substitua pela sua chave da API

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      if (await Permission.microphone.request().isGranted) {
        await _recorder.openRecorder();
        await _recorder.setSubscriptionDuration(Duration(milliseconds: 10));
        print('Microphone permission granted');
      } else {
        print('Microphone permission denied');
      }
    } catch (e) {
      print('Error initializing recorder: $e');
    }
  }

  Future<void> _startRecording() async {
    try {
      await _recorder.startRecorder(toFile: 'audio.wav');
      setState(() {
        _isRecording = true;
      });
      print('Recording started');
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      _recordedFilePath = 'audio.wav'; // Armazena o caminho do arquivo gravado
      _transcribeAudio();
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _transcribeAudio() async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_recordedFilePath != null) {
        final file = File(_recordedFilePath!);
        final audioBytes = await file.readAsBytes();
        final audioBase64 = base64Encode(audioBytes);

        // Criar a requisição à API
        final url = Uri.parse('https://speech.googleapis.com/v1/speech:recognize');
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'config': {
              'encoding': 'LINEAR16',
              'sampleRateHertz': 44100,
              'languageCode': 'pt-BR', // Define o idioma da transcrição
              'model': 'command_and_search', // Define o modelo da API
            },
            'audio': {'content': audioBase64},
          }),
        );

        // Tratar a resposta
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _transcriptionResult = data['results'][0]['alternatives'][0]['transcript'];
            _isLoading = false;
          });
        } else {
          print('Error transcribing audio: ${response.statusCode}');
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        print('Recording not found');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error transcribing audio: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transcrição de ${widget.sala}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Transcrição: $_transcriptionResult'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Parar Gravação' : 'Iniciar Gravação'),
            ),
            SizedBox(height: 20),
            if (_isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }
}
