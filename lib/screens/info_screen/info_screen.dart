import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Info"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            "DeepChemistry",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Bei DeepChemistry handelt es sich um ein Projekt zur Erkennung handschriftlicher Strukturformeln mithilfe künstlicher Intelligenz.\n\n\nIn dieser Phase des Projektes geht es erst einmal darum, genügend dieser Strukturfomeln zu sammeln, um damit eine erste künstliche Intelligenz trainieren zu können.\n\n\nWenn dieses Ziel erreicht ist, kann die KI trainiert und verbessert werden. Außerdem ist ein Programm geplant, mit dem die Zeichnungen gescannt werden können und zur weiteren Benutzung und Analyse zur Verfügung stehen.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
