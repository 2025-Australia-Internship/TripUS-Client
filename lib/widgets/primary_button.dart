import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color color;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
