import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Future<void> _sendFeedback() async {
    final Email email = Email(
      body: 'Mi opinión sobre la aplicación es...',
      subject: 'Retroalimentación sobre la aplicación',
      recipients: ['desarrollador@ejemplo.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opinión'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendFeedback,
          child: Text('Enviar Opinión'),
        ),
      ),
    );
  }
}
