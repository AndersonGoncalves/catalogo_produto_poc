import 'package:flutter/material.dart';

class AdaptativeFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? mini;

  const AdaptativeFloatingActionButton({
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor,
    this.foregroundColor,
    this.mini = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? const SizedBox()
        : FloatingActionButton(
          mini: mini!,
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.secondary,
          foregroundColor:
              foregroundColor ?? Theme.of(context).textTheme.labelLarge!.color,
          onPressed: onPressed,
          child: Icon(icon),
        );
  }
}
