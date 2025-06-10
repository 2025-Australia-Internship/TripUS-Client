import 'package:flutter/material.dart';
import 'package:tripus/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final Widget? actionIcon;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    this.text,
    this.actionIcon,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: dark08,
            )
          : null,
      title: Text(
        text ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: dark08,
        ),
      ),
      actions: actionIcon != null ? [actionIcon!] : null,
    );
  }
}
