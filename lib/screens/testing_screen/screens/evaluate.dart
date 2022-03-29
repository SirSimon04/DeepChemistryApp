import 'dart:typed_data';

import 'package:flutter/material.dart';

class EvaluateScreen extends StatefulWidget {
  final Uint8List image;

  const EvaluateScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<EvaluateScreen> createState() => _EvaluateScreenState();
}

class _EvaluateScreenState extends State<EvaluateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ergebnis",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.memory(widget.image),
          ),
        ],
      ),
    );
  }
}
