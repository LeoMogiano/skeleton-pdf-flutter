import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial'), centerTitle: true),
      body: const Center(child: Text('Contenido del Historial')),
    );
  }
}
