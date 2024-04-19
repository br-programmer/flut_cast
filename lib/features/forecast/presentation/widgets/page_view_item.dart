import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flut_cast/features/forecast/presentation/widgets/rain_forecast_per_day.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageViewItem extends ConsumerWidget {
  const PageViewItem({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(forecastNotifier(city)).forecast;
    final temp = (forecast?.current.temp ?? 0).toInt();
    final current = forecast?.current;
    final weather = current?.weather[0];
    final daily = forecast?.daily[0];
    final min = (daily?.temp.min ?? 0).toInt();
    final max = (daily?.temp.max ?? 0).toInt();
    return SafeArea(
      bottom: false,
      child: ListView(
        children: [
          gap32,
          WeatherByLocation(
            city: city.city,
            temperature: temp,
            currentWeather: weather?.description ?? '',
            maximumTemperature: max,
            minimunTemperature: min,
            myLocation: city.myLocation,
          ),
          gap32,
          RainForecast(
            hourly: forecast?.hourlies ?? [],
            title: daily?.summary ?? '',
          ),
          gap8,
          RainForecastPerDay(daily: forecast?.daily ?? []),
          gap8,
          ForecastForTheMoon(
            moonrise: daily?.moonrise ?? 0,
            moonset: daily?.moonset ?? 0,
            moonPhase: daily?.moonPhase ?? 0,
          ),
          gap8,
          ForecastUvAndSensation(
            uvi: (current?.uvi ?? 0).toInt(),
            feelsLike: (current?.feelsLike ?? 0).toInt(),
            warm: (current?.humidity ?? 0) > (current?.temp ?? 0),
            uviDayli: (daily?.uvi ?? 0).toInt(),
          ),
          gap20,
          PressureAndHumidity(
            pressure: current?.pressure ?? 0,
            windSpeed: current?.windSpeed ?? 0,
            windDeg: (current?.windDeg ?? 0).toDouble(),
          ),
        ],
      ),
    );
  }
}
