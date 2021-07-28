import 'package:flutter/material.dart';

class ControllerButton extends StatelessWidget {
  const ControllerButton({
    required this.onStateChanged,
    this.child,
    this.color,
    this.radius,
    Key? key,
  }) : super(key: key);

  final Function(bool isPressed) onStateChanged;
  final Widget? child;
  final Color? color;
  final double? radius;

  factory ControllerButton.text({
    required String text,
    required Function(bool isPressed) onStateChanged,
    TextStyle? style,
    Color? textColor,
    Color? color,
    double? radius,
  }) =>
      ControllerButton(
        onStateChanged: onStateChanged,
        color: color,
        radius: radius,
        child: Text(
          text,
          style: style ??
              TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onStateChanged(true),
      onTapUp: (_) => onStateChanged(false),
      onTapCancel: () => onStateChanged(false),
      child: Container(
        width: radius ?? 60,
        height: radius ?? 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
