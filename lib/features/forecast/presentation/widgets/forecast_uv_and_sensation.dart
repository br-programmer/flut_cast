import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/features/forecast/presentation/extensions/num_x.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class ForecastUvAndSensation extends StatelessWidget {
  const ForecastUvAndSensation({
    super.key,
    required this.uvi,
    required this.feelsLike,
    required this.warm,
    required this.uviDayli,
  });
  final int uvi;
  final int uviDayli;
  final int feelsLike;
  final bool warm;

  @override
  Widget build(BuildContext context) {
    final n = warm ? 1 : 2;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FCCard(
            iconData: Icons.sunny,
            padding: edgeInsets4.copyWith(left: 20, right: 4),
            title: context.texts.forecast.sensation.uv.title.toUpperCase(),
            child: Padding(
              padding: edgeInsetsH20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$uvi',
                    style: context.textTheme.headlineLarge,
                  ),
                  Text(
                    uvi.indiceUv,
                    style: context.textTheme.displayLarge,
                  ),
                  gap20,
                  FcSlider(
                    padding: EdgeInsets.zero,
                    minimumValue: uvi.toDouble(),
                    maximunValue: uvi.toDouble(),
                    colors: const [Colors.green, Colors.orange],
                    colorMinumun: Colors.white,
                  ),
                  gap20,
                  Text(
                    context.texts.forecast.sensation.uv.description(
                      level: uviDayli.indiceUv,
                    ),
                    style: context.textTheme.titleLarge,
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
            title: context.texts.forecast.sensation.title.toUpperCase(),
            child: Padding(
              padding: edgeInsetsH20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: feelsLike),
                    duration: duration750ms,
                    builder: (_, value, __) => Text(
                      '$value°C',
                      style: context.textTheme.headlineLarge,
                    ),
                  ),
                  gap57,
                  Text(
                    context.texts.forecast.sensation.humedity(n: n),
                    style: context.textTheme.titleLarge,
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
