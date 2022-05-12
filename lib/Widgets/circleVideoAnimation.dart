import 'package:flutter/material.dart';

class CircleVideoAnimation extends StatefulWidget {
  CircleVideoAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);
  Widget child;

  @override
  State<CircleVideoAnimation> createState() => _CircleVideoAnimationState();
}

class _CircleVideoAnimationState extends State<CircleVideoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.forward();
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: widget.child,
    );
  }
}
