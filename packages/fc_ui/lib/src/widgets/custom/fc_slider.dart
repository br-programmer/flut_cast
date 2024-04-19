import 'package:fc_ui/fc_ui.dart';
import 'package:flutter/material.dart';

class FcSlider extends StatelessWidget {
  const FcSlider({
    super.key,
    required this.minimumValue,
    required this.maximunValue,
    this.padding,
    this.colors,
    this.colorMinumun,
  });

  final double minimumValue;
  final double maximunValue;
  final EdgeInsetsGeometry? padding;
  final List<Color>? colors;
  final Color? colorMinumun;
  @override
  Widget build(BuildContext context) {
    final width = 100.0;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: width,
            height: 4,
            decoration: BoxDecoration(
              color: Palette.grey10,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  height: 4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: colors ??
                          [
                            Palette.orange5,
                            Palette.orange10,
                          ],
                      stops: [0.1, 0.9],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (maximunValue >= 25)
            Positioned(
              left: (maximunValue >= 26
                      ? maximunValue == 100
                          ? maximunValue - 6
                          : maximunValue + 10
                      : 0.0)
                  .clamp(0, 100),
              child: Container(
                alignment: Alignment.center,
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Palette.grey10,
                  shape: BoxShape.circle,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            left: (minimumValue).clamp(0, 100),
            child: Container(
              alignment: Alignment.center,
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Palette.grey10,
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: colorMinumun ?? Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double calculateNearestValue(
    {required double referencevalue,
    required double minumun,
    required double maximun}) {
  double minimunDistance = (referencevalue - minumun).abs();
  double maximunDistance = (referencevalue - maximun).abs();

  if (minimunDistance < maximunDistance) {
    return minumun; // valor1 está más cerca
  } else {
    return maximun; // valor2 está más cerca o son igualmente cercanos
  }
}
