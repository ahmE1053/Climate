import 'package:flutter/material.dart';
import 'statless.dart';
import 'main screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      // routes: {
      //   '/': (context) => const MyApp(),
      //   '/s': (context) => const Main(),
      // },
    ),
  );
}
