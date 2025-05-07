import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Widget? actionIcon;

  const CustomAppBar({
    super.key,
    required this.text,
    this.actionIcon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 23,
          color: Colors.black,
        ),
      ),
      actions: actionIcon != null ? [actionIcon!] : null,
    );
  }
}
