import 'package:flutter/material.dart';

class CloseIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double size;

  const CloseIconButton({
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
