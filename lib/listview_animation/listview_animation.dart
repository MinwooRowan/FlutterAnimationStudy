import 'dart:async';
import 'dart:math';

import 'package:animation_study/listview_animation/widget/card_widget.dart';
import 'package:flutter/material.dart';

class ListViewAnimation extends StatefulWidget {
  const ListViewAnimation({super.key});

  @override
  State<ListViewAnimation> createState() => _ListViewAnimationState();
}

class _ListViewAnimationState extends State<ListViewAnimation>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final ScrollController scrollController;

  bool detectUserEvent = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
      upperBound: pi * 2,
    )..drive(CurveTween(curve: Curves.bounceInOut));
    animationController.repeat();
    scrollController = ScrollController();
  }

  List<Color> cardColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
  ];

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!detectUserEvent) {
        scrollController.animateTo(scrollController.offset + 7,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut);
      }
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.9),
              Colors.black,
            ],
            stops: const [
              0,
              0.22,
              0.5,
            ],
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          child: NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                animationController.repeat();
                setState(() {
                  detectUserEvent = false;
                });
              }
              return true;
            },
            child: Listener(
              onPointerDown: (event) {
                animationController.stop();
                setState(() {
                  detectUserEvent = true;
                });
              },
              child: ListView.separated(
                shrinkWrap: true,
                controller: scrollController,
                padding: const EdgeInsets.symmetric(vertical: 300),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: animationController,
                    child: CardWidget(
                        cardColor: cardColor[index % cardColor.length]),
                    builder: (context, child) {
                      var value = sin(
                        index.isOdd
                            ? -animationController.value
                            : animationController.value,
                      );
                      return Transform.translate(
                        offset: Offset(0, value * 30),
                        child: child,
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 8);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
