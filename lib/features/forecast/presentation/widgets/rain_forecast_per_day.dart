import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RainForecastPerDay extends ConsumerWidget {
  const RainForecastPerDay({super.key, required this.daily});
  final List<Daily> daily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = daily.length;
    final imageUrl = ref.read(Providers.enviroment).imageUrl;
    return FCCard(
      title: context.texts.forecast.forecasts(n: days, days: days),
      iconData: Icons.date_range,
      child: Padding(
        padding: edgeInsetsH20,
        child: Column(
          children: daily.mapList(
            (d) {
              final date = d.dt.fromEpoch;
              final icon = d.weather.first.icon;
              final temp = d.temp;
              final day = date.today
                  ? context.texts.forecast.today
                  : date.dayLetter(LocaleSettings.currentLocale.languageCode);
              return Column(
                children: [
                  DescriptionRainForecast(
                    days: day.capitalize(),
                    max: temp.max,
                    min: temp.min,
                    imageUrl: '$imageUrl/$icon.png',
                  ),
                  if (daily.indexOf(d) < daily.length - 1)
                    const Divider(thickness: .35),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DescriptionRainForecast extends StatelessWidget {
  const DescriptionRainForecast({
    super.key,
    required this.days,
    required this.min,
    required this.max,
    this.temperature,
    this.imageUrl,
  });

  final String days;
  final double min;
  final double max;
  final int? temperature;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            days,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: AppFontWeight.semiBold,
              color: Palette.white,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: Center(child: FCCachedImage(url: imageUrl!, width: 24)),
        ),
        space20,
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Text(
                '${min.toInt()}°',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                  color: Palette.white.withOpacity(.4),
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Center(
                  child: FcSlider(
                    maximunValue: max,
                    minimumValue: min,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${max.toInt()}°',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: AppFontWeight.semiBold,
                    color: Palette.white,
                    fontSize: 20,
                  ),
                ),
              ),
              space10,
            ],
          ),
        ),
      ],
    );
  }
}
