import 'package:flutter/material.dart';
import 'package:rpn_calculator/calculator.dart';
import 'package:yaru/yaru.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: yaruDark,
      home: const RPNCalculator(),
    );
  }
}
