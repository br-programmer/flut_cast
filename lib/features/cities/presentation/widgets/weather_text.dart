import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherText extends ConsumerWidget {
  const WeatherText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: 1 - ref.watch(StateNotifiers.scrollPercent).clamp(0, 1),
      child: Padding(
        padding: edgeInsetsH20,
        child: Text(
          context.texts.misc.weather,
          style: context.textTheme.headlineMedium,
        ),
      ),
    ).toSliver;
  }
}
