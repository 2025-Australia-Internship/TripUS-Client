import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

enum MessageType { error, success }

class StatusMessage extends StatelessWidget {
  final String message;
  final MessageType type;

  const StatusMessage({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (type) {
      case MessageType.error:
        color = error;
        break;
      case MessageType.success:
        color = success;
        break;
    }

    return Text(
      message,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
