import 'package:flutter/material.dart';
import 'package:flutter_deep_chemistry/screens/drawing_screen/components/custom_draw_widget.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final GlobalKey<CustomDrawingWidgetState> _customDrawingWidgetStateKey =
      GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Ausprobieren",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                child: CustomDrawingWidget(
                  key: _customDrawingWidgetStateKey,
                ),
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.blue,
            child: MaterialButton(
              onPressed: () {
                print("pressed");
                _customDrawingWidgetStateKey.currentState!.evaluate();
              },
              minWidth: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.07,
              child: const Text(
                "Berechnen",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
