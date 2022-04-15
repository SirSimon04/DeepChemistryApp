import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_chemistry/screens/drawing_screen/components/custom_draw_widget.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../widgets/loader.dart';
import 'dart:io' show Platform;

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
    "assets/new_formulas/2-Methylbutan.png",
    "assets/new_formulas/2-Methylhexan.png",
    "assets/formulas/2-Methylpentan.png",
    "assets/formulas/2-Methylpropan.png",
    "assets/formulas/3-Ethylpentan.png",
    "assets/formulas/3-Methylhexan.png",
    "assets/formulas/3-Methylpentan.png",
    "assets/formulas/22-Dimethylbutan.png",
    "assets/formulas/22-Dimethylpentan.png",
    "assets/formulas/22-Dimethylpropan.png",
    "assets/formulas/23-Dimethylbutan.png",
    "assets/formulas/23-Dimethylpentan.png",
    "assets/formulas/24-Dimethylpentan.png",
    "assets/formulas/33-Dimethylpentan.png",
    "assets/formulas/223-Trimethylbutan.png",
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
      backgroundColor: Colors.grey,
      appBar: PlatformAppBar(
        title: const Text("Zeichne etwas"),
        trailingActions: [
          GestureDetector(
            onTap: () => _customDrawingWidgetStateKey.currentState!.clear(),
            child: Icon(
              context.platformIcon(
                material: Icons.delete,
                cupertino: Icons.delete,
              ),
            ),
          ),
          // PlatformIconButton(
          //   onPressed: () => _customDrawingWidgetStateKey.currentState!.clear(),
          //   materialIcon: const Icon(Icons.delete),
          //   cupertinoIcon: const Icon(CupertinoIcons.delete),
          // ),
        ],
      ),
      material: (_, __) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF2CE8F5),
          child: const Icon(Icons.save),
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });
            await _customDrawingWidgetStateKey.currentState!.save();
            updateImage();
            setState(() {
              _isLoading = false;
            });
          },
        ),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Platform.isIOS
              ? Positioned(
                  bottom: 95,
                  right: 10,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xFF2CE8F5),
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await _customDrawingWidgetStateKey.currentState!.save();
                      updateImage();
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Icon(
                      context.platformIcon(
                        material: Icons.save,
                        cupertino: CupertinoIcons.cloud_upload_fill,
                      ),
                    ),
                  ),
                )
              : Container(),
          Container(
            child: _isLoading ? const Loader() : Container(),
          ),
        ],
      ),
    );
  }
}
