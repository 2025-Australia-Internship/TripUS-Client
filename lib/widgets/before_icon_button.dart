import 'package:flutter/material.dart';

class BeforeIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;

  const BeforeIconButton({
    super.key,
    required this.onPressed,
    this.color = Colors.black,
    this.size = 25,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.close_rounded),
      color: color,
      iconSize: size,
    );
  }
}
