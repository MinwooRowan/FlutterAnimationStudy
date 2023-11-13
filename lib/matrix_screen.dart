import 'package:flutter/material.dart';

class MatrixScreen extends StatefulWidget {
  const MatrixScreen({super.key});

  @override
  State<MatrixScreen> createState() => _MatricScreenState();
}

class _MatricScreenState extends State<MatrixScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
            transform: Matrix4.identity()
              ..rotateX(0)
              ..rotateY(0)
              ..rotateZ(0),
            child: const Text('Hello World')),
      ),
    );
  }
}
