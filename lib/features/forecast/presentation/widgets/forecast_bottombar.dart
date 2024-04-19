import 'package:fc_ui/fc_ui.dart';
import 'package:flut_cast/core/core.dart';
import 'package:flut_cast/features/features.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForecastBottomBar extends ConsumerWidget {
  const ForecastBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(citiesNotifier).cities.length;
    final currentPage = ref.watch(StateNotifiers.currentPage);

    return ClipRRect(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.25),
          border: const Border(
            top: BorderSide(color: Palette.white, width: .25),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: edgeInsetsH20,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: context.pop,
                      child: const Icon(Icons.list_rounded, size: 30),
                    ),
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        total,
                        (index) {
                          final color = index == currentPage
                              ? Palette.white
                              : Palette.grey.withOpacity(.1);
                          late Widget icon;
                          if (index == 0) {
                            icon = Icon(Icons.near_me, size: 12, color: color);
                          } else {
                            icon = SizedBox.square(
                              dimension: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          }
                          return Row(
                            children: [
                              icon,
                              if (index < total - 1) space6,
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
