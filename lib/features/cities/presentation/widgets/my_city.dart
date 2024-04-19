import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dismissible_tile/flutter_dismissible_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyCity extends ConsumerWidget {
  const MyCity({super.key, required this.city, required this.index});
  final City city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(forecastNotifier(city)).forecast;
    final temp = (forecast?.current.temp ?? 0).toInt();
    final current = forecast?.current;
    final weather = current?.weather[0];
    final daily = forecast?.daily[0];
    final min = (daily?.temp.min ?? 0).toInt();
    final max = (daily?.temp.max ?? 0).toInt();
    final background = weather?.background;

    return Hero(
      tag: city.id!,
      child: Material(
        type: MaterialType.transparency,
        child: ClipRRect(
          borderRadius: borderRadius20,
          child: FCGradient(
            child: DismissibleTile(
              ltrOverlayIndent: 0,
              rtlBackground: const ColoredBox(color: Colors.red),
              confirmDismiss: (direction) {
                if (city.myLocation) return Future.value();
                if (direction == DismissibleTileDirection.rightToLeft) {
                  return ref.read(citiesNotifier.notifier).deleteCity(city);
                }
                return Future.value();
              },
              key: ValueKey(city.id),
              child: InkWell(
                onTap: () {
                  ref.read(StateNotifiers.currentPage.notifier).change(index);
                  context
                      .pushNamed(Routes.forecast.name, extra: {'index': index});
                },
                child: AspectRatio(
                  aspectRatio: 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (background != null)
                        background.image(fit: BoxFit.cover),
                      Padding(
                        padding: edgeInsetsH20.add(edgeInsetsV12),
                        child: Column(
                          children: [
                            _Header(
                              city: city,
                              temp: temp,
                              hour: current?.dt.fromEpoch.hourComplete ?? '',
                            ),
                            const Spacer(),
                            _Footer(weather: weather, max: max, min: min),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.city,
    required this.temp,
    required this.hour,
  });

  final City city;
  final int temp;
  final String hour;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city.myLocation ? context.texts.misc.myLocation : city.city,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              Text(
                city.myLocation ? city.city : hour,
                style: context.textTheme.titleLarge,
              ),
            ],
          ),
        ),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: temp),
          duration: duration750ms,
          builder: (_, value, __) => Text(
            '$value°',
            style: context.textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.weather,
    required this.max,
    required this.min,
  });

  final Weather? weather;
  final int max;
  final int min;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          weather?.description.capitalize() ?? '',
          style: context.textTheme.titleLarge,
        ),
        const Spacer(),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: max),
          duration: duration750ms,
          builder: (_, value, __) => Text(
            context.texts.forecast.temperature.maximum(degree: value),
            style: context.textTheme.titleLarge,
          ),
        ),
        space16,
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: min),
          duration: duration750ms,
          builder: (_, value, __) => Text(
            context.texts.forecast.temperature.minimum(degree: value),
            style: context.textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
