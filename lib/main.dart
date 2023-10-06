import 'package:animation_study/rotate_3d_animation.dart';
import 'package:animation_study/rotate_3d_animation_by_scroll.dart';
import 'package:animation_study/size_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Rotate3DAnimation(),
      ),
    );
  }
}
