import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EvaluateScreen extends StatefulWidget {
  final Uint8List image;

  const EvaluateScreen({Key? key, required this.image}) : super(key: key);

  @override
  State<EvaluateScreen> createState() => _EvaluateScreenState();
}

class _EvaluateScreenState extends State<EvaluateScreen> {
  // MemoryImage _image = MemoryImage(widget.image);
  //Todo: Evaluate what it might be, ideally with tensorflow lite model

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Ergebnis"),
      ),
      // appBar: AppBar(
      //   title: const Text(
      //     "Ergebnis",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
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
