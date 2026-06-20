import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:    padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:        color ?? AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withAlpha(13),
            blurRadius: 12,
            offset:     const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
