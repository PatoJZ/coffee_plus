import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  // Declaramos la variable _questions para almacenar las preguntas cargadas
  Map<String, List<Map<String, dynamic>>> _questions = {};

  // Método para cargar las preguntas desde el archivo JSON
  Future<void> _loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/feedback_questions.json');
    final Map<String, dynamic> data = json.decode(response);

    setState(() {
      // Convertimos cada sección del JSON en una lista tipificada
      _questions = data.map((key, value) {
        return MapEntry(key, List<Map<String, dynamic>>.from(value));
      });
    });
  }

  // Este método prepara y envía el correo
  Future<void> _sendFeedbackEmail() async {
    String name = _nameController.text;
    String relationship = _relationshipController.text;
    String questionResponses = _generateQuestionResponses();

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'patojimenez08@gmail.com',
      queryParameters: {
        'subject': 'Feedback de la aplicación',
        'body':
            'Nombre: $name\nParentesco: $relationship\n\n$questionResponses',
      },
    );

    try {
      if (await canLaunch(emailUri.toString())) {
        await launch(emailUri.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No se puede abrir el cliente de correo.")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al intentar abrir el cliente de correo")),
      );
    }
  }

  // Genera una cadena con las respuestas a las preguntas
  String _generateQuestionResponses() {
    StringBuffer buffer = StringBuffer();
    _questions.forEach((section, questions) {
      buffer.writeln('$section:');
      for (var question in questions) {
        buffer.writeln(
            '${question["titulo"]} - Respuesta: ${question["valor"]}/5');
      }
      buffer.writeln('\n');
    });
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _relationshipController,
              decoration: InputDecoration(
                labelText: "Parentesco",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Aquí muestra las preguntas con su sistema de calificación
            Expanded(
              child: ListView(
                children: _buildQuestionWidgets(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendFeedbackEmail,
              child: Text("Enviar Feedback"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions(); // Cargamos las preguntas cuando se inicializa el widget
  }

  List<Widget> _buildQuestionWidgets() {
    List<Widget> widgets = [];
    _questions.forEach((section, questions) {
      widgets.add(Text(section, style: TextStyle(fontWeight: FontWeight.bold)));
      for (var question in questions) {
        widgets.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question["titulo"]),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < question["valor"] ? Icons.star : Icons.star_border,
                  ),
                  onPressed: () {
                    setState(() {
                      question["valor"] = index + 1;
                    });
                  },
                );
              }),
            ),
          ],
        ));
      }
    });
    return widgets;
  }
}
