import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
            [Color.fromARGB(255, 175, 54, 30), Color.fromARGB(1, 226, 76, 12)]),
      ),
    ),
  );
}
