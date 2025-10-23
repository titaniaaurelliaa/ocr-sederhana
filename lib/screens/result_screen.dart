import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String ocrText;
  const ResultScreen({super.key, required this.ocrText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Pindai'),
      ), // AppBar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            ocrText, // tampilkan teks utuh dengan baris baru
            style: const TextStyle(fontSize: 16),
          ), // Text
        ), // SingleChildScrollView
      ), // Padding

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (Route<dynamic> route) => false, // hapus semua halaman di atas HomeScreen
          );
        },
        child: const Icon(Icons.home),
      ), // FloatingActionButton
    ); // Scaffold
  }
}