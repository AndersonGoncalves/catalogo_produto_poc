import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Function() onPressed;
  const AdaptativeButton(
    this.label, {
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 0,
    this.height = 40,
    this.width = double.infinity,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
              ),

              minimumSize: Size(width!, height!),
              //backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
              //foregroundColor: foregroundColor ?? Colors.white,
              backgroundColor: backgroundColor ?? Colors.amber,
              foregroundColor: foregroundColor ?? Colors.black87,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(label),
          );
  }
}
