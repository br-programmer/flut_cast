import 'dart:math';
import 'dart:ui';

import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PressureAndHumidity extends StatelessWidget {
  const PressureAndHumidity({
    super.key,
    required this.pressure,
    required this.windSpeed,
    required this.windDeg,
  });
  final int pressure;
  final double windSpeed;
  final double windDeg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FCCard(
            iconData: Icons.punch_clock_rounded,
            padding: edgeInsets4.copyWith(left: 20, right: 4),
            title: context.texts.forecast.pressure.toUpperCase(),
            child: Padding(
              padding: edgeInsetsH20,
              child: Column(
                children: [
                  SleekCircularSlider(
                    initialValue: 80,
                    appearance: CircularSliderAppearance(
                      infoProperties: InfoProperties(
                        mainLabelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        modifier: (percentage) {
                          final formatter = NumberFormat('#,##,000');
                          final fort = formatter.format(pressure);
                          final roundedValue = fort;
                          return roundedValue;
                        },
                        bottomLabelText: 'hPa',
                        bottomLabelStyle: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      size: 140,
                      customWidths: CustomSliderWidths(
                        progressBarWidth: 7,
                        handlerSize: 6,
                      ),
                      customColors: CustomSliderColors(
                        hideShadow: true,
                        trackColor: Colors.white54,
                        progressBarColors: Palette.progressBarColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: FCCard(
            iconData: Icons.thermostat_sharp,
            padding: edgeInsets4.copyWith(left: 4, right: 20),
            title: context.texts.forecast.wend.toUpperCase(),
            child: Padding(
              padding: edgeInsetsH20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Assets.images.compass.provider(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            child: CustomPaint(
                              painter: WindDirectionPainter(windDeg),
                              size: const Size(
                                150,
                                150,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 1,
                              top: 1.5,
                            ),
                            child: Align(
                              child: Stack(
                                children: [
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaY: 10,
                                      sigmaX: 10,
                                    ),
                                  ),
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            windSpeed.toStringAsFixed(0),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            'km/h',
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.90),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WindDirectionPainter extends CustomPainter {
  WindDirectionPainter(this.windDirection);
  final double windDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final arrowLength = size.height * 0.95;
    final arrowWidth = size.width * 0.07;
    final arrowHeadWidth = arrowWidth * 1;
    final arrowHeadLength = size.width * 0.15;

    final path = Path()
      ..moveTo(-arrowLength / 2, 0)
      ..lineTo(arrowLength / 2 - arrowHeadLength, 0)
      ..lineTo(arrowLength / 2 - arrowHeadLength, -arrowHeadWidth / 2)
      ..lineTo(arrowLength / 2, 0)
      ..lineTo(arrowLength / 2 - arrowHeadLength, arrowHeadWidth / 2)
      ..lineTo(arrowLength / 2 - arrowHeadLength, 0)
      ..lineTo(-arrowLength / 2, 0)
      ..close();

    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2 - 0.1)
      ..rotate(windDirection * (pi / 180))
      ..drawPath(path, paint)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
