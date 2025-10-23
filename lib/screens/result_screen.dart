import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final String ocrText;

  const ResultScreen({super.key, required this.ocrText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final FlutterTts _flutterTts;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();

    _flutterTts.setLanguage("id-ID");

    _flutterTts.setStartHandler(() {
      setState(() => _isSpeaking = true);
    });
    _flutterTts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });
    _flutterTts.setErrorHandler((msg) {
      setState(() => _isSpeaking = false);
    });
  }

  Future<void> _speak() async {
    final text = widget.ocrText.isEmpty ? 'Tidak ada teks untuk dibacakan.' : widget.ocrText;
    try {
      await _flutterTts.stop();
      await _flutterTts.speak(text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memulai TTS.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil OCR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            tooltip: 'Bacakan Teks',
            onPressed: _speak,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText(
            widget.ocrText.isEmpty ? 'Tidak ada teks ditemukan.' : widget.ocrText,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}