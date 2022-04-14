import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_deep_chemistry/services/http.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Validator extends StatefulWidget {
  const Validator({Key? key}) : super(key: key);

  @override
  State<Validator> createState() => _ValidatorState();
}

class _ValidatorState extends State<Validator> {
  List<dynamic> images = [];

  Future<void> updateImages() async {
    List<dynamic> cur = [];

    cur = await httpHelper.getValidationImages();

    setState(() {
      images = cur;
    });
  }

  HttpHelper httpHelper = HttpHelper();

  @override
  void initState() {
    super.initState();
    updateImages();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: images.isEmpty
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ResponsiveGridList(
              horizontalGridSpacing: 16, // Horizontal space between grid items
              verticalGridSpacing: 16, // Vertical space between grid items
              horizontalGridMargin: 16, // Horizontal space around the grid
              verticalGridMargin: 16, // Vertical space around the grid
              minItemWidth:
                  300, // The minimum item width (can be smaller, if the layout constraints are smaller)
              minItemsPerRow:
                  1, // The minimum items to show in a single row. Takes precedence over minItemWidth
              maxItemsPerRow: 5,
              children: images
                  .map((e) => ValidatorCard(
                        name: e["name"],
                        base: e["base64"],
                        path: e["path"],
                        onPressed: () {
                          List cur = images;
                          cur.removeWhere(
                              (element) => element["path"] == e["path"]);
                          setState(() {
                            images = cur;
                          });
                        },
                      ))
                  .toList(),
            ),
    );
  }
}

class ValidatorCard extends StatelessWidget {
  final String name;
  final String base;
  final String path;
  final VoidCallback onPressed;

  const ValidatorCard({
    Key? key,
    required this.name,
    required this.base,
    required this.path,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              name,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // child: Image.memory(base64Decode(base64)),
              child: Image.memory(
                base64.decode(
                  base.replaceAll(RegExp('\\s+'), ''),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    onPressed();
                    HttpHelper().delete(path);
                  },
                  child: const Text(
                    "Löschen",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onPressed();
                    HttpHelper().validate(path);
                  },
                  child: const Text(
                    "Akzeptieren",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
