import 'package:flutter/material.dart';

class QButton extends StatelessWidget {
  const QButton(
    this.label, {
    Key? key,
    this.color,
    this.labelColor,
    this.onPressed,
    this.child,
  }) : super(key: key);

  factory QButton.withChild({
    required Widget child,
    Color? color,
    VoidCallback? onPressed,
  }) =>
      QButton(
        '',
        child: child,
        color: color,
        onPressed: onPressed,
      );

  final String label;
  final Color? labelColor;
  final Color? color;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child ??
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: labelColor,
              ),
            ),
        style: ButtonStyle(
          backgroundColor:
              color != null ? MaterialStateProperty.all(color) : null,
        ),
      ),
    );
  }
}
