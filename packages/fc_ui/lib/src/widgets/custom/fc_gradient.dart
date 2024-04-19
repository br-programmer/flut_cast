import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/material.dart';

class FCGradient extends StatelessWidget {
  const FCGradient({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: Palette.gradient,
        ),
      ),
      child: child,
    );
  }
}
