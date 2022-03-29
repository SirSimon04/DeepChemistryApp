import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_deep_chemistry/screens/drawing_screen/components/custom_draw_widget.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../widgets/loader.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final GlobalKey<CustomDrawingWidgetState> _customDrawingWidgetStateKey =
      GlobalKey();

  String curImage = "assets/formulas/2-Methylbutan.jpg";

  bool _isLoading = false;

  List<String> formulas = [
    "assets/formulas/2-Methylbutan.jpg",
    "assets/formulas/2-Methylhexan.jpg",
    "assets/formulas/2-Methylpentan.jpg",
    "assets/formulas/2-Methylpropan.jpg",
    "assets/formulas/3-Ethylpentan.jpg",
    "assets/formulas/3-Methylhexan.jpg",
    "assets/formulas/3-Methylpentan.jpg",
    "assets/formulas/22-Dimethylbutan.jpg",
    "assets/formulas/22-Dimethylpentan.jpg",
    "assets/formulas/22-Dimethylpropan.jpg",
    "assets/formulas/23-Dimethylbutan.jpg",
    "assets/formulas/23-Dimethylpentan.jpg",
    "assets/formulas/24-Dimethylpentan.jpg",
    "assets/formulas/33-Dimethylpentan.jpg",
    "assets/formulas/223-Trimethylbutan.jpg",
    "assets/formulas/Butan.jpg",
    "assets/formulas/Ethan.jpg",
    "assets/formulas/Heptan.jpg",
    "assets/formulas/Hexan.jpg",
    "assets/formulas/Pentan.jpg",
    "assets/formulas/Propan.jpg",
  ];

  void updateImage() {
    int min = 0;
    int max = formulas.length - 1;
    Random rnd = Random();
    int r = min + rnd.nextInt(max - min);
    setState(() {
      curImage = formulas[r].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    updateImage();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text(
      //     "Zeichne etwas",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () => _customDrawingWidgetStateKey.currentState!.clear(),
      //       icon: const Icon(Icons.delete),
      //     )
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.save),
      //   onPressed: () async {
      //     //TODO: add loading indicator
      //     setState(() {
      //       _isLoading = true;
      //     });
      //     await _customDrawingWidgetStateKey.currentState!.save();
      //     updateImage();
      //     setState(() {
      //       _isLoading = false;
      //     });
      //   },
      // ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Image(
                    image: AssetImage(curImage),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomDrawingWidget(
                      key: _customDrawingWidgetStateKey,
                      curImage: curImage.substring(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: _isLoading ? const Loader() : Container(),
          ),
        ],
      ),
    );
  }
}
