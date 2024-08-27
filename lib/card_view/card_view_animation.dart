import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardViewAnimation extends StatefulWidget {
  const CardViewAnimation({
    super.key,
    required this.controller,
    required this.front,
    required this.back,
    this.enableGesture = false,
  });
  final CardController controller;
  final Widget front;
  final Widget back;
  final bool enableGesture;

  @override
  State<CardViewAnimation> createState() => _CardViewAnimationState();
}

class _CardViewAnimationState extends State<CardViewAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationcontroller;
  late Animation<double> rotateAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  void initAnimation() {
    animationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationcontroller,
        curve: Curves.decelerate,
      ),
    );
    widget.controller._controller = animationcontroller;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotateAnimation,
      builder: (context, child) {
        final angle = math.pi * rotateAnimation.value;
        final isFront = setCardView(angle);
        return Stack(
          children: [
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isFront
                  ? widget.front
                  : Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: widget.back,
                    ),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: onTap,
              ),
            ),
          ],
        );
      },
    );
  }

  void onTap() {
    if (!widget.enableGesture) return;
    if (animationcontroller.isAnimating) return;
    if (animationcontroller.isCompleted) {
      animationcontroller.reverse();
    } else {
      animationcontroller.forward();
    }
  }

  bool setCardView(double angle) {
    const d90 = math.pi / 2;
    if (angle > d90) return false;
    return true;
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }
}

class CardController {
  late AnimationController _controller;

  void forward() => _controller.forward();

  void reverse() => _controller.reverse();
}
