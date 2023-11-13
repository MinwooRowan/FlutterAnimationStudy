import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Color cardColor;
  const CardWidget({super.key, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cardColor,
      ),
    );
  }
}
