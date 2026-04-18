import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final bool isFront;
  final VoidCallback? onFlip;

  const AnimatedFlipCard({
    Key? key,
    required this.front,
    required this.back,
    required this.isFront,
    this.onFlip,
  }) : super(key: key);

  @override
  State<AnimatedFlipCard> createState() => _AnimatedFlipCardState();
}

class _AnimatedFlipCardState extends State<AnimatedFlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _isFront = widget.isFront;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
     if (!_isFront) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedFlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFront != oldWidget.isFront) {
      if (widget.isFront && _controller.isCompleted) {
        _controller.reverse();
      } else if (!widget.isFront && _controller.isDismissed) {
        _controller.forward();
      }
      _isFront = widget.isFront;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isAnimating) return;
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
        widget.onFlip?.call();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          // When angle > pi/2, we see the back, so we reflect it to avoid mirroring
          final isBackVisible = angle >= pi / 2;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isBackVisible
                ? Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: widget.back,
                  )
                : widget.front,
          );
        },
      ),
    );
  }
}
