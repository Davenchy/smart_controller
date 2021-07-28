import 'dart:math' show max, min;

import 'package:flutter/material.dart';

class TouchPad extends StatefulWidget {
  TouchPad({
    Key? key,
    required this.onPositionChanged,
    this.diameter = 180,
    this.stickDiameter = 60,
    this.defaultPositionOffset = const Offset(0.5, 0.5),
    this.resetToDefaultPosition = true,
    this.backgroundColor,
    this.stickColor,
  }) : super(key: key);

  final double diameter;
  final double stickDiameter;
  final Offset defaultPositionOffset;
  final bool resetToDefaultPosition;
  final Color? backgroundColor;
  final Color? stickColor;
  final void Function(Offset position) onPositionChanged;

  @override
  _TouchPadState createState() => _TouchPadState();
}

class _TouchPadState extends State<TouchPad> {
  Offset _position = Offset(0, 0);

  double get top => climbPosition(_position.dy);

  double get left => climbPosition(_position.dx);

  double climbPosition(double offset) {
    final double maxValue = widget.diameter - widget.stickDiameter;
    return max(0, min(200, offset * maxValue));
  }

  @override
  void initState() {
    super.initState();
    setState(() => _position = widget.defaultPositionOffset);
    widget.onPositionChanged(_position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        double dx = max(0, min(1, details.localPosition.dx / widget.diameter));
        double dy = max(0, min(1, details.localPosition.dy / widget.diameter));
        final position = Offset(dx, dy);

        if (position != _position) {
          setState(() => _position = position);

          widget.onPositionChanged(_position);

          // x = (maximum - minimum) * d + minimum
        }
      },
      onVerticalDragEnd: (_) {
        if (widget.resetToDefaultPosition &&
            _position != widget.defaultPositionOffset) {
          setState(() => _position = widget.defaultPositionOffset);
          widget.onPositionChanged(_position);
        }
      },
      child: Container(
        width: widget.diameter,
        height: widget.diameter,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.backgroundColor ?? Theme.of(context).primaryColor,
              blurRadius: 1.0,
              spreadRadius: 5.0,
            ),
            BoxShadow(
              color: Colors.white,
              blurRadius: 10.0,
              spreadRadius: 3.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              child: Container(
                width: widget.stickDiameter,
                height: widget.stickDiameter,
                decoration: BoxDecoration(
                  color: widget.stickColor ?? Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.stickColor ?? Colors.blue,
                      blurRadius: 1.0,
                      spreadRadius: 5.0,
                    ),
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: 3.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
