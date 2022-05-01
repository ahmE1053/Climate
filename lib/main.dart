import 'package:flutter/material.dart';
import 'Screens/selecting_screen.dart';
import 'Screens/result_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SelectingScreen(),
      // routes: {
      //   '/': (context) => const MyApp(),
      //   '/s': (context) => const Main(),
      // },
    ),
  );
}
