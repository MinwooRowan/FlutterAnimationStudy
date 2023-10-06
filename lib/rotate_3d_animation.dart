import 'package:flutter/material.dart';

class Rotate3DAnimation extends StatefulWidget {
  const Rotate3DAnimation({super.key});

  @override
  State<Rotate3DAnimation> createState() => _Rotate3DAnimationState();
}

class _Rotate3DAnimationState extends State<Rotate3DAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _cardRotateController;

  double initialDrag = 0.0;

  @override
  void initState() {
    super.initState();
    _cardRotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: -1.0,
      upperBound: 1.5,
    )..addListener(() {
        setState(() {}); // 상태 업데이트를 위해 추가된 리스너
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        initialDrag = details.localPosition.dx;
      },
      onVerticalDragUpdate: (details) {
        double difference = details.localPosition.dx - initialDrag;
        double fractionDifference = -difference / context.size!.width; // 여기를 변경
        _cardRotateController.value = fractionDifference;
      },
      onVerticalDragEnd: (details) {
        _cardRotateController.animateTo(0,
            duration: const Duration(milliseconds: 200));
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: AnimatedBuilder(
            animation: Tween<double>(begin: -1.6, end: 1.5)
                .animate(_cardRotateController),
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateZ(-30)
                  ..rotateY(0.15)
                  ..rotateX(_cardRotateController.value),
                alignment: Alignment.center,
                child: Container(
                  width: 360,
                  height: 240,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    gradient: RadialGradient(
                      radius: 1.3,
                      colors: const [
                        Color.fromARGB(255, 217, 220, 255),
                        Colors.red,
                      ],
                      center: Alignment(_cardRotateController.value - 0.7,
                          -_cardRotateController.value + 0.7),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardRotateController.dispose();
    super.dispose();
  }
}
