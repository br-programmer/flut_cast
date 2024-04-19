import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RainForecast extends ConsumerWidget {
  const RainForecast({
    super.key,
    required this.title,
    required this.hourly,
  });
  final String title;
  final List<Hourly> hourly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = ref.read(Providers.enviroment).imageUrl;
    return FCCard(
      title: title.capitalize(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: edgeInsetsL20,
        child: Row(
          children: hourly.mapList(
            (hourly) {
              final date = hourly.dt.fromEpoch;
              final weather = hourly.weather.first;
              final path = weather.icon;
              final hour =
                  date.now ? context.texts.forecast.now : date.hourNumber;
              return Padding(
                padding: edgeInsetsR20,
                child: Column(
                  children: [
                    Text(
                      hour,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: AppFontWeight.semiBold,
                        color: Palette.white,
                      ),
                    ),
                    gap4,
                    FCCachedImage(url: '$imageUrl/$path.png', width: 24),
                    gap4,
                    Text(
                      '${hourly.temp.toStringAsFixed(0)}°',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: AppFontWeight.semiBold,
                        color: Palette.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
