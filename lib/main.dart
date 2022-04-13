import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_chemistry/screens/drawing_screen/drawing_screen.dart';
import 'package:flutter_deep_chemistry/screens/info_screen/info_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'screens/testing_screen/testing_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      cupertino: (_, __) => const CupertinoApp(
        title: "DeepChemistry",
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF2CE8F5),
        ),
        home: MyApp(),
      ),
      material: (_, __) => MaterialApp(
        title: "DeepChemistry",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(primaryColor: const Color(0xFF2CE8F5)),
        home: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [DrawingScreen(), InfoScreen()];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      bottomNavBar: PlatformNavBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              context.platformIcon(
                material: Icons.border_color,
                cupertino: CupertinoIcons.pencil,
              ),
            ),
            label: "Zeichnen",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              context.platformIcon(
                material: Icons.info,
                cupertino: CupertinoIcons.info_circle_fill,
              ),
            ),
            label: "Info",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     context.platformIcon(
          //       material: Icons.image,
          //       cupertino: CupertinoIcons.photo,
          //     ),
          //   ),
          //   label: "Testen",
          // ),
        ],
        itemChanged: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
