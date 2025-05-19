import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';
import 'package:tripus/widgets/status_message.dart';

class CommonTextfield extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? suffixText;
  final VoidCallback? onSuffixPressed;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final String? statusMessage;
  final MessageType? messageType;

  const CommonTextfield({
    super.key,
    required this.label,
    this.controller,
    this.suffixText,
    this.onSuffixPressed,
    this.onChanged,
    this.enabled = true,
    this.statusMessage,
    this.messageType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          enabled: enabled,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: light08, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: light08, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: (suffixText != null)
                ? Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: onSuffixPressed != null
                        ? TextButton(
                            onPressed: onSuffixPressed,
                            child: Text(
                              suffixText!,
                              style: TextStyle(
                                color: MainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(
                            width: 10,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              suffixText!,
                              style: TextStyle(
                                color: MainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  )
                : null,
          ),
        ),
        SizedBox(height: 3),
        if (statusMessage != null && messageType != null)
          Align(
            alignment: Alignment.centerRight,
            child: StatusMessage(message: statusMessage!, type: messageType!),
          ),
        SizedBox(height: 20),
      ],
    );
  }
}
