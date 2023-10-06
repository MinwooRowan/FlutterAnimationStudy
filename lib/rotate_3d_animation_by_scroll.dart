import 'package:flutter/material.dart';

class Rotate3DAnimationByScroll extends StatefulWidget {
  const Rotate3DAnimationByScroll({super.key});

  @override
  State<Rotate3DAnimationByScroll> createState() => _Rotate3DAnimationState();
}

class _Rotate3DAnimationState extends State<Rotate3DAnimationByScroll>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _cardRotateController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..addListener(() => setState(() {}));

  double offset = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          offset = (_scrollController.offset / 120).clamp(-0.2, 1.2);
        });
      });
    _cardRotateController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: SizedBox(
            height: 240,
            width: 360,
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(0.5),
                  alignment: Alignment.center,
                  child: Container(
                    width: 380, // 화면 너비보다 50 픽셀 더 크게 설정
                    height: 140,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.redAccent, Colors.red],
                      ),
                    ),

                    child: const Center(
                      child: Text(
                        'Hello World',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
