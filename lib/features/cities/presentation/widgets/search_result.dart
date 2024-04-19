import 'package:fc_common/fc_common.dart';
import 'package:fc_domain/fc_domain.dart';
import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchResult extends ConsumerWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(search)) {
      final SearchedState state when state.cities.isEmpty => SearchEmptyState(
          query: state.query,
        ),
      final SearchedState state => SearchedResult(cities: state.cities),
      _ => const SizedBox.shrink().toSliver,
    };
  }
}

class SearchedResult extends ConsumerWidget {
  const SearchedResult({super.key, required this.cities});

  final List<City> cities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.builder(
      itemBuilder: (_, index) => ListTile(
        onTap: () async {
          final added = await PreviewCity.show(context, cities[index]);
          if (added != null && added) {
            ref.read(citiesNotifier.notifier).addNewCity(cities[index]);
            ref.read(StateNotifiers.searchFocus.notifier).change(false);
            ref.read(search.notifier).search('');
          }
        },
        title: Text(cities[index].title),
        visualDensity: VisualDensity.compact,
        contentPadding: edgeInsetsZero,
        minVerticalPadding: 0,
      ),
      itemCount: cities.length,
    );
  }
}

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 60, color: Palette.white.withOpacity(.7)),
          gap4,
          Text(
            context.texts.cities.noResults,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: AppFontWeight.bold,
            ),
          ),
          gap4,
          Text(
            context.texts.cities.noResultsFound(query: query),
            style: context.textTheme.bodySmall?.copyWith(
              color: Palette.white.withOpacity(.7),
              fontWeight: AppFontWeight.light,
            ),
          ),
        ],
      ),
    );
  }
}

class PreviewCity extends ConsumerWidget {
  const PreviewCity({super.key, required this.city});
  final City city;

  static Future<bool?> show(BuildContext context, City city) {
    return showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => PreviewCity(city: city),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCities = ref.read(citiesNotifier).cities;
    final exist = myCities.firstWhereOrNull((c) => c.title == city.title);
    final forecast = ref.watch(forecastNotifier(city)).forecast;
    final weather = forecast?.current.weather.first;
    final shaderData = weather?.shaderData;
    return SizedBox(
      height: context.mediaQuery.size.height * .85,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: FCGradient(
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (shaderData != null) FCWeatherShader(shaderData: shaderData),
              PageViewItem(city: city),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text(
                        context.texts.cities.cancel,
                        style: context.textTheme.bodyLarge,
                      ),
                      onPressed: () => context.pop(false),
                    ),
                    if (exist == null)
                      CupertinoButton(
                        child: Text(
                          context.texts.cities.save,
                          style: context.textTheme.bodyLarge,
                        ),
                        onPressed: () => context.pop(true),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
