import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class CommonTextfield extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onSuffixPressed;
  final String? suffixText;

  const CommonTextfield({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.onSuffixPressed,
    this.suffixText,
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
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: light08, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: light08, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: (onSuffixPressed != null && suffixText != null)
                ? Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: TextButton(
                      onPressed: onSuffixPressed,
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
      ],
    );
  }
}
