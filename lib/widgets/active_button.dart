import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class ActiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const ActiveButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: enabled ? MainColor : grey01,
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
          color: enabled ? Colors.white : grey03,
        ),
      ),
    );
  }
}
