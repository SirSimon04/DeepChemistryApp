import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_chemistry/screens/validation_screen/components/validation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  bool loggedIn = false;

  void checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    bool? loggedIn = prefs.getBool("loggedIn");

    if (loggedIn == true) {
      setState(() {
        loggedIn = true;
      });
    } else {
      setState(() {
        loggedIn = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Überprüfen"),
      ),
      body: loggedIn
          ? const Validator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: "Geben Sie das Passwort ein",
                        onSubmitted: (text) async {
                          if (text == "Test1234") {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool("loggedIn", true);
                            setState(() {
                              loggedIn = true;
                            });
                          }
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Geben Sie das Passwort ein",
                            filled: true,
                          ),
                          onSubmitted: (text) async {
                            if (text == "Test1234") {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool("loggedIn", true);
                              setState(() {
                                loggedIn = true;
                              });
                            }
                          },
                        ),
                      )
              ],
            ),
    );
  }
}
