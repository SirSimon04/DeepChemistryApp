import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_deep_chemistry/screens/drawing_screen/components/sketcher.dart';
import 'package:flutter_deep_chemistry/services/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import "package:screenshot/screenshot.dart";

import 'drawn_line.dart';

class CustomDrawingWidget extends StatefulWidget {
  final String curImage;
  const CustomDrawingWidget({Key? key, required this.curImage})
      : super(key: key);

  @override
  CustomDrawingWidgetState createState() => CustomDrawingWidgetState();
}

class CustomDrawingWidgetState extends State<CustomDrawingWidget> {
  final GlobalKey _globalKey = GlobalKey();
  List<DrawnLine> lines = <DrawnLine>[];
  Color selectedColor = Colors.black;
  double selectedWidth = 20.0;
  DrawnLine line = DrawnLine([], Colors.black, 0.0);
  StreamController<List<DrawnLine>> linesStreamController =
      StreamController<List<DrawnLine>>.broadcast();
  StreamController<DrawnLine> currentLineStreamController =
      StreamController<DrawnLine>.broadcast();
  ScreenshotController screenshotController = ScreenshotController();

  HttpHelper http = HttpHelper();

  void printSomething() {
    print("Moin");
  }

  Future<void> save() async {
    try {
      Uint8List image = await screenshotController.capture() ?? Uint8List(0);

      await http.uploadImage(image: image, filename: widget.curImage);

      clear();
    } catch (e) {
      print(e);
    }
  }

  Future<void> clear() async {
    setState(() {
      lines = [];
      line = DrawnLine([], Colors.black, 0.0);
    });
  }

  void onPanStart(DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    line = DrawnLine([point], selectedColor, selectedWidth);
    currentLineStreamController.add(line);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    final List<Offset> path = List.from(line.path)..add(point);
    line = DrawnLine(path, selectedColor, selectedWidth);

    currentLineStreamController.add(line);
  }

  void onPanEnd(DragEndDetails details) {
    lines = List.from(lines)..add(line);
    linesStreamController.add(lines);
  }

  GestureDetector buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<DrawnLine>(
            stream: currentLineStreamController.stream,
            builder: (context, snapshot) {
              return CustomPaint(
                painter: Sketcher(
                  lines: [line],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<DrawnLine>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: Sketcher(
                lines: lines,
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget buildStrokeButton(double strokeWidth) {
  //   return GestureDetector(
  //     onTap: () {
  //       selectedWidth = strokeWidth;
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(4.0),
  //       child: Container(
  //         width: strokeWidth * 2,
  //         height: strokeWidth * 2,
  //         decoration: BoxDecoration(
  //             color: selectedColor, borderRadius: BorderRadius.circular(20.0)),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget buildColorToolbar() {
  //   return Positioned(
  //     top: 40.0,
  //     right: 10.0,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         buildClearButton(),
  //         const Divider(
  //           height: 10.0,
  //         ),
  //         buildSaveButton(),
  //         const Divider(
  //           height: 20.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget buildColorButton(Color color) {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: FloatingActionButton(
  //       mini: true,
  //       backgroundColor: color,
  //       child: Container(),
  //       onPressed: () {
  //         setState(() {
  //           selectedColor = color;
  //         });
  //       },
  //     ),
  //   );
  // }
  //
  // Widget buildSaveButton() {
  //   return GestureDetector(
  //     onTap: save,
  //     child: const CircleAvatar(
  //       child: Icon(
  //         Icons.save,
  //         size: 20.0,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget buildClearButton() {
  //   return GestureDetector(
  //     onTap: clear,
  //     child: const CircleAvatar(
  //       child: Icon(
  //         Icons.create,
  //         size: 20.0,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            // height: constraints.maxHeight,
            // width: constraints.maxWidth,
            color: Colors.yellow[50],
            child: Stack(
              children: [
                buildAllPaths(context),
                buildCurrentPath(context),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    linesStreamController.close();
    currentLineStreamController.close();
    super.dispose();
  }
}
