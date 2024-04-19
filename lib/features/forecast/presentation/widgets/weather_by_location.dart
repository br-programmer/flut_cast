import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class WeatherByLocation extends StatelessWidget {
  const WeatherByLocation({
    super.key,
    required this.city,
    required this.temperature,
    required this.currentWeather,
    required this.maximumTemperature,
    required this.minimunTemperature,
    required this.myLocation,
  });
  final String city;
  final int temperature;
  final String currentWeather;
  final int maximumTemperature;
  final int minimunTemperature;
  final bool myLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          myLocation ? context.texts.misc.myLocation : city,
          style: context.textTheme.headlineMedium?.copyWith(
            letterSpacing: 1,
            fontWeight: AppFontWeight.medium,
          ),
        ),
        if (myLocation)
          Text(
            city.toUpperCase(),
            style: context.textTheme.titleLarge?.copyWith(
              letterSpacing: 1,
              fontWeight: AppFontWeight.bold,
            ),
          ),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: temperature),
          duration: duration750ms,
          builder: (_, value, __) => Text(
            '$value°',
            style: context.textTheme.headlineLarge?.copyWith(
              fontSize: 100,
              fontWeight: AppFontWeight.light,
            ),
          ),
        ),
        Text(
          currentWeather.capitalize(),
          style: context.textTheme.titleLarge?.copyWith(
            letterSpacing: 1,
            fontSize: 20,
            fontWeight: AppFontWeight.regular,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: maximumTemperature),
              duration: duration750ms,
              builder: (_, value, __) => Text(
                context.texts.forecast.temperature.maximum(degree: value),
                style: context.textTheme.titleLarge?.copyWith(
                  letterSpacing: 1,
                  fontSize: 20,
                  fontWeight: AppFontWeight.regular,
                ),
              ),
            ),
            space20,
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: minimunTemperature),
              duration: duration750ms,
              builder: (_, value, __) => Text(
                context.texts.forecast.temperature.minimum(degree: value),
                style: context.textTheme.titleLarge?.copyWith(
                  letterSpacing: 1,
                  fontSize: 20,
                  fontWeight: AppFontWeight.regular,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
