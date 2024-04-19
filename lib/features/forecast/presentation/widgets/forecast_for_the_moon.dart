import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/features/forecast/presentation/extensions/num_x.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class ForecastForTheMoon extends StatelessWidget {
  const ForecastForTheMoon({
    super.key,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
  });
  final int moonrise;
  final int moonset;
  final double moonPhase;

  @override
  Widget build(BuildContext context) {
    return FCCard(
      title: moonPhase.title.toUpperCase(),
      iconData: Icons.dark_mode,
      child: Padding(
        padding: edgeInsetsH20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  MoonInformation(
                    title: context.texts.forecast.moon.moonrise,
                    description: moonrise.fromEpoch.hourComplete,
                  ),
                  const Divider(thickness: .5),
                  MoonInformation(
                    title: context.texts.forecast.moon.moonset,
                    description: moonset.fromEpoch.hourComplete,
                  ),
                  const Divider(thickness: .5),
                  MoonInformation(
                    title: context.texts.forecast.moon.moonPhase,
                    description: moonPhase.phase,
                  ),
                ],
              ),
            ),
            space4,
            const Align(
              alignment: Alignment.centerRight,
              child: FCCachedImage(
                width: 90,
                url:
                    'https://purepng.com/public/uploads/large/purepng.com-moonmoon-lightmoonastronomical-bodynatural-satellite-1411527067060v3hee.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoonInformation extends StatelessWidget {
  const MoonInformation({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
        ),
        space4,
        Text(
          description,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
