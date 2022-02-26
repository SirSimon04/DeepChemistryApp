import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_deep_chemistry/screens/drawing_screen/components/custom_draw_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'components/drawn_line.dart';
import 'components/sketcher.dart';
import "package:screenshot/screenshot.dart";

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final GlobalKey<CustomDrawingWidgetState> _customDrawingWidgetStateKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Zeichne etwas",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => _customDrawingWidgetStateKey.currentState!.clear(),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () => _customDrawingWidgetStateKey.currentState!.save(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Image(
                image: AssetImage("assets/formulas/24-Dimethylpentan.jpg"),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomDrawingWidget(
                  key: _customDrawingWidgetStateKey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
