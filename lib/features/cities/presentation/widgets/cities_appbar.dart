import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CitiesAppBar extends StatefulHookConsumerWidget {
  const CitiesAppBar({super.key});

  @override
  ConsumerState<CitiesAppBar> createState() => CitiesAppBarState();
}

class CitiesAppBarState extends ConsumerState<CitiesAppBar>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: duration175ms,
    reverseDuration: duration150ms,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(StateNotifiers.searchFocus, (_, focus) {
      final value = controller.value;
      if (focus) {
        controller.forward(from: value);
      } else {
        controller.reverse(from: value);
      }
    });
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => SliverAppBar(
        pinned: true,
        toolbarHeight: 40 * (1 - controller.value),
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: AnimatedOpacity(
          duration: kThemeAnimationDuration,
          opacity: ref.watch(StateNotifiers.scrollPercent).clamp(0, 1),
          child: Text(
            context.texts.misc.weather,
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
