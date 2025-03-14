import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../config/constants.dart';

class LoadingWidget extends StatefulWidget {
  final double size;
  final Color color;
  final int duration;
  const LoadingWidget({
    super.key,
    this.size = 200.0,
    this.color = blue,
    this.duration = 2500,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final double angle1 = 2 * math.pi * _controller.value;
        final double angle2 =
            2 * math.pi * (_controller.value + 0.5); // Offset by half a cycle

        return SizedBox(
          height: widget.size,
          width: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Semi-transparent orbit paths
              // Container(
              //   width: widget.size * 0.8,
              //   height: widget.size * 0.8,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: widget.color.withValues(alpha: 0.2),
              //       width: 1,
              //     ),
              //   ),
              // ),
              // First circle
              Positioned(
                left:
                    widget.size / 2 +
                    (widget.size * 0.2) * math.cos(angle1) -
                    widget.size * 0.15,
                top:
                    widget.size / 2 +
                    (widget.size * 0.2) * math.sin(angle1) -
                    widget.size * 0.15,
                child: Container(
                  width: widget.size * 0.3,
                  height: widget.size * 0.3,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Second circle
              Positioned(
                left:
                    widget.size / 2 +
                    (widget.size * 0.2) * math.cos(angle2) -
                    widget.size * 0.15,
                top:
                    widget.size / 2 +
                    (widget.size * 0.2) * math.sin(angle2) -
                    widget.size * 0.15,
                child: Container(
                  width: widget.size * 0.3,
                  height: widget.size * 0.3,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
